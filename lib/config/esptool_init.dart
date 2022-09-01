import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/run_command.dart';
import 'package:mpespkit/utilities/parse_result.dart';

Future<dynamic> esptoolInit() async {
  final installed = await runCommand(
      command: "python",
      args: ["-m", "esptool", "-h"],
      successMsg: "Validated esptool installation",
      failureMsg:
          "Failed to validate esptool installation, attempting to install esptool...",
      strict: true);

  if (!installed) {
    final result = await Process.run(
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
          bool retry = confirm("Try again?");
          if (retry) return esptoolInit();
          exit(0);
        });
  }
}
