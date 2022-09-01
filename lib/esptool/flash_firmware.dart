import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/esptool/erase_flash.dart';
import 'package:mpespkit/selectors/baud_select.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/process_utils.dart';

Future<void> flashFirmware(
    {required String device,
    required String port,
    required File firmware}) async {
  String baud = baudSelect();

  sleep(1);
  print(blue("Flashing new MicroPython firmware on to the device... \n"));
  sleep(2);
  print(green("Press and hold the BOOT button now!"));
  sleep(1);
  print(green("Flashing in 2..."));
  sleep(1);
  print(green("Flashing in 1..."));
  sleep(1);
  print(
      green("Flashing, do not disconnect the device (this may take a while)"));

  ProcessResult result = await Process.run(
      "python",
      [
        "-m",
        "esptool",
        "-c",
        device,
        "-p",
        port,
        "-b",
        baud,
        "write_flash",
        "-z",
        "0x1000",
        firmware.path
      ],
      runInShell: true);

  return parseResult(
      result: result,
      onSuccess: (ProcessResult res) {
        print(green("Flashed new firmware successfuly! \n"));
        sleep(2);
      },
      onFailure: (ProcessResult res) {
        print(orange("Failed to flash new firmware on to the device"));
        print(orange(res.stderr != "" ? res.stderr : res.stdout));
        sleep(1);

        return tryAgain(callback: () => eraseFlash(device: device, port: port));
      });
}
