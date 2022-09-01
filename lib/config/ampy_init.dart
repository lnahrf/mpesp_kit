import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/process_utils.dart';

Future<dynamic> ampyInit() async {
  final installed = await runCommand(
      command: "ampy",
      args: [],
      successMsg: "Validated adafruit-ampy installation \n",
      failureMsg:
          "Failed to validate adafruit-ampy installation, attempting to install adafruit-ampy...");

  if (!installed) {
    ProcessResult result = await Process.run(
        "python", ["-m", "pip", "install", "adafruit-ampy"],
        runInShell: true);

    return parseResult(
        result: result,
        onSuccess: (ProcessResult res) {
          print("Installed adafruit-ampy successfuly!");
        },
        onFailure: (ProcessResult res) async {
          print(orange("Failed to install adafruit-ampy"));
          print(orange(res.stderr != "" ? res.stderr : res.stdout));
          sleep(1);

          return tryAgain(callback: ampyInit, exit: () => exit(0));
        });
  }
}
