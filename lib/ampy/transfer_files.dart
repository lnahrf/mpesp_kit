import 'dart:io';
import 'package:dcli/dcli.dart';
import 'dart:async';

import 'package:mpespkit/ampy/soft_reset.dart';

Future<void> transferFiles(
    {required String device,
    required String port,
    required List<String> paths}) async {
  print(orange("""
  *Please note that if your device is running or will be running an infinite loop (e.g. while True) the file transfer process will never end.
  It's likely the process will timeout, when it does please check if the file transferred or not using the Serial Shell tool.
  """));

  final cont = confirm(orange(" Do you understand?"));
  if (!cont) return;

  final timeout = ask("Enter timeout in seconds:",
      defaultValue: "30", validator: Ask.integer);
  print(blue("Timeout is set to ${timeout} seconds \n"));
  sleep(1);

  final transfer = confirm("Transfer files?");
  if (!transfer) return;

  List<String> failedPaths = [];

  for (final path in paths) {
    print(blue("Transferring ${path} (this may take a while)"));

    final process = await Process.start("ampy", ["--port", port, "put", path],
        runInShell: true);

    final timer = Timer(Duration(seconds: int.parse(timeout)), () async {
      print(orange("Timeout reached, killing file transfer process."));
      await Process.killPid(process.pid);
    });

    final exitCode = await process.exitCode;
    timer.cancel();

    if (exitCode != 0) {
      print(orange("Failed to transfer ${path}"));
      failedPaths.add(path);
    } else {
      print(blue("Transferred ${path} successfuly"));
    }
  }

  sleep(1);

  if (failedPaths.length > 0) {
    final retry = confirm("Try failed transfers again?");
    if (retry)
      return transferFiles(device: device, port: port, paths: failedPaths);
  }

  final reset = confirm("Reset device?");
  if (reset) return softReset(device: device, port: port);
}
