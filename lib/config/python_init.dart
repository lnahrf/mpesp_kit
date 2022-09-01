import 'package:mpespkit/utilities/process_utils.dart';

Future<dynamic> pythonInit() async {
  return runCommand(
      command: "python",
      args: ["-V"],
      successMsg: "Validated Python installation",
      failureMsg:
          "Failed to validate Python installation, make sure Python is on your PATH environment variable.",
      strict: true);
}
