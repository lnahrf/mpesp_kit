import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/process_utils.dart';

Future<void> eraseFlash({required String device, required String port}) async {
  bool cont = confirm("Reset the device's firmware?");
  if (!cont) return;
  sleep(1);
  print(blue("Resetting the device's firmware... \n"));
  sleep(2);
  print(green("Press and hold the BOOT button now!"));
  sleep(1);
  print(green("Erasing flash in 2..."));
  sleep(1);
  print(green("Erasing flash in 1..."));
  sleep(1);
  print(green(
      "Erasing flash, do not disconnect the device (this may take a while)"));

  ProcessResult result = await Process.run(
      "python", ["-m", "esptool", "--chip", device, "-p", port, "erase_flash"],
      runInShell: true);

  return parseResult(
      result: result,
      onSuccess: (ProcessResult res) {
        print(green("Erased flash successfuly! \n"));
        sleep(1);
      },
      onFailure: (ProcessResult res) {
        print(orange("Failed to reset the firmware on the device"));
        print(orange(res.stderr != "" ? res.stderr : res.stdout));
        sleep(1);

        return tryAgain(callback: () => eraseFlash(device: device, port: port));
      });
}
