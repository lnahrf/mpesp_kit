import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/cli_utils.dart';

Future<void> softReset({required String device, required String port}) async {
  try {
    print(blue("Sending soft reset signal to device..."));
    Process process = await Process.start(
        "ampy", ["-p", port, "run", "import machine; machine.soft_reset()"],
        runInShell: true);
    sleep(3);
    Process.killPid(process.pid);
    print(blue("Soft reset signal sent successfuly \n"));
    sleep(1);
  } catch (exception) {
    print(orange("Failed to send soft reset signal to the device"));
    print(orange(exception.toString()));
    return tryAgain(callback: () => softReset(device: device, port: port));
  }
}
