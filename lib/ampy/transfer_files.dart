import 'dart:io';
import 'package:dcli/dcli.dart';
import 'dart:async';

import 'package:mpespkit/ampy/soft_reset.dart';
import 'package:mpespkit/selectors/baud_select.dart';
import 'package:mpespkit/selectors/timeout_select.dart';
import 'package:mpespkit/utilities/process_utils.dart';

Future<void> transferFiles(
    {required String device,
    required String port,
    required List<String> paths}) async {
  print(orange(
      "Please note that if your device is running or will be running an infinite loop (e.g. while True) the file transfer process will never end."));
  print(orange(
      "It's likely the process will timeout, when it does please check if the file transferred or not using the Serial Shell tool."));

  bool cont = confirm(orange("Do you understand?"));
  if (!cont) return;

  String timeout = timeoutSelect();
  String baud = baudSelect();

  bool transfer = confirm("Transfer files?");
  if (!transfer) return;

  List<String> failedPaths = await _transferFileLoop(
      paths: paths, port: port, baud: baud, timeout: timeout);

  sleep(1);

  if (failedPaths.length > 0) {
    print(orange("Failed to transfer:"));
    for (String failedPath in failedPaths) print(orange(failedPath));

    bool retry = confirm("Try again?");
    if (retry)
      return transferFiles(device: device, port: port, paths: failedPaths);
  }

  bool reset = confirm("Reset device?");
  if (reset) return softReset(device: device, port: port);
}

Future<List<String>> _transferFileLoop(
    {required List<String> paths,
    required String port,
    required String baud,
    required String timeout}) async {
  List<String> failedPaths = [];

  for (final path in paths) {
    print(blue("Transferring ${path} (this may take a while)"));

    Process process = await Process.start(
        "ampy", ["-p", port, "-b", baud, "put", path],
        runInShell: true);

    Timer timer = killPidTimer(
        pid: process.pid,
        duration: int.parse(timeout),
        message: "Timeout reached, killing file transfer process");

    int exitCode = await process.exitCode;
    timer.cancel();

    if (exitCode != 0) {
      print(orange("Failed to transfer ${path}"));
      failedPaths.add(path);
    } else {
      print(blue("Transferred ${path} successfuly \n"));
    }
  }

  return failedPaths;
}
