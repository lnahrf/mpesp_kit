import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/run_command.dart';
import 'package:mpespkit/utilities/parse_result.dart';
import 'package:mpespkit/utilities/try_again.dart';

Future<void> esptoolInit() async {
  final installed = await runCommand(
      command: "python",
      args: ["-m", "esptool", "-h"],
      successMsg: "Validated esptool installation",
      failureMsg:
          "Failed to validate esptool installation, attempting to install esptool...",
      strict: true);

  if (!installed) {
    ProcessResult result = await Process.run(
        "python", ["-m", "pip", "install", "esptool"],
        runInShell: true);

    return parseResult(
        result: result,
        onSuccess: (ProcessResult res) {
          print("Installed esptool successfuly!");
        },
        onFailure: (ProcessResult res) {
          print(orange("Failed to install esptool"));
          print(orange(res.stderr != "" ? res.stderr : res.stdout));
          sleep(1);

          return tryAgain(callback: esptoolInit, exit: () => exit(0));
        });
  }
}
