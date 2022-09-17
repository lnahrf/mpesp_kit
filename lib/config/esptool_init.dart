import 'package:mpespkit/utilities/process_utils.dart';

Future<void> esptoolInit() async {
  await runCommand(
      command: "python",
      args: ["-m", "esptool", "-h"],
      successMsg: "Validated esptool installation",
      failureMsg:
          "Failed to validate esptool installation, run \"pip install esptool\"");
}
