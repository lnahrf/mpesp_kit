import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/esptool/erase_flash.dart';
import 'package:mpespkit/utilities/parse_result.dart';

Future<void> flashFirmware(
    {required String device,
    required String port,
    required File firmware}) async {
  final baud = ask("Enter transmission speed (baud):",
      defaultValue: "115200", validator: Ask.integer);
  print(blue("Transmission speed set to ${baud} \n"));
  sleep(1);
  print(blue("Flashing new MicroPython firmware on to your device..."));
  sleep(2);
  print(green("Press and hold the BOOT button now!"));
  sleep(1);
  print(green("Flashing in 2..."));
  sleep(1);
  print(green("Flashing in 1..."));
  sleep(1);
  print(green(
      "Flashing, please do not disconnect your device (this may take a while)"));

  final result = await Process.run(
      "python",
      [
        "-m",
        "esptool",
        "--chip",
        device,
        "--port",
        port,
        "--baud",
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
        sleep(1);
      },
      onFailure: (ProcessResult res) {
        print(orange("Failed to flash new firmware on to your device"));
        print(orange(res.stderr != "" ? res.stderr : res.stdout));
        sleep(1);
        bool retry = confirm("Try again?");
        sleep(1);
        if (retry) return eraseFlash(device: device, port: port);
      });
}
