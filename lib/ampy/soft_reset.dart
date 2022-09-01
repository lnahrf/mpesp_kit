import 'dart:io';
import 'package:dcli/dcli.dart';

Future<void> softReset({required String device, required String port}) async {
  print(blue("Sending soft reset signal to device..."));
  final process = await Process.start(
      "ampy", ["-p", port, "run", "import machine; machine.soft_reset()"],
      runInShell: true);
  sleep(3);
  Process.killPid(process.pid);
  print(blue("Soft reset signal sent successfuly \n"));
  sleep(1);
}
