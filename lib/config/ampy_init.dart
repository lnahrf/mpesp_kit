import 'package:mpespkit/utilities/process_utils.dart';

Future<dynamic> ampyInit() async {
  await runCommand(
      command: "ampy",
      args: ["--help"],
      successMsg: "Validated adafruit-ampy installation \n",
      failureMsg:
          "Failed to validate adafruit-ampy installation, run \"pip install adafruit-ampy\"");
}
