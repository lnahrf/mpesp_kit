import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/run_command.dart';
import 'package:mpespkit/utilities/parse_result.dart';

Future<dynamic> ampyInit() async {
  final installed = await runCommand(
      command: "ampy",
      args: [],
      successMsg: "Validated adafruit-ampy installation \n",
      failureMsg:
          "Failed to validate adafruit-ampy installation, attempting to install adafruit-ampy...");

  if (!installed) {
    final result = await Process.run(
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
          bool retry = confirm("Try again?");
          if (retry) return ampyInit();
          exit(0);
        });
  }
}
