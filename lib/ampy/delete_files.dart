import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/parse_result.dart';
import 'package:mpespkit/utilities/try_again.dart';

Future<void> deleteFiles({required String device, required String port}) async {
  final files = await getAllFiles(device: device, port: port);
  if (files.length == 0) {
    print(orange("No files found"));
    return sleep(2);
  }

  print(blue("Files:"));
  print(blue(files.join("\n") + "\n"));
  sleep(1);

  final file = ask(
      "Enter the path of the file you want to delete (enter * to delete all files):");

  bool fileNotFound = file != "*" && !files.any((item) => item == file);
  if (fileNotFound) {
    print(orange("\nCould not file ${file} in file list \n"));
    sleep(1);

    return tryAgain(
        callback: () => deleteFiles(device: device, port: port), exit: () {});
  }

  final timeout = ask("Enter timeout in seconds:",
      defaultValue: "30", validator: Ask.integer);
  print(blue("Timeout is set to ${timeout} seconds \n"));

  sleep(1);

  if (file == "*")
    return deleteAllFiles(timeout: timeout, paths: files, port: port);

  return deleteFile(timeout: timeout, path: file, port: port);
}

Future<void> deleteFile(
    {required String timeout,
    required String path,
    required String port}) async {
  print(blue("Deleting ${path} (this may take a while)"));

  final process =
      await Process.start("ampy", ["-p", port, "rm", path], runInShell: true);
  Timer timer = Timer(Duration(seconds: int.parse(timeout)), () async {
    print(orange("Timeout reached, killing file deletion process."));
    await Process.killPid(process.pid);
  });

  final exitCode = await process.exitCode;
  timer.cancel();

  if (exitCode != 0) {
    print(orange("Failed to delete ${path}"));

    return tryAgain(
        callback: () => deleteFile(timeout: timeout, path: path, port: port));
  } else {
    print(blue("Deleted ${path} successfuly"));
    sleep(1);
  }
}

Future<void> deleteAllFiles(
    {required String timeout,
    required List<String> paths,
    required String port}) async {
  for (final path in paths)
    await deleteFile(timeout: timeout, path: path, port: port);
}

Future<dynamic> getAllFiles(
    {required String device, required String port}) async {
  print(blue("Retreiving file list (this may take a while) \n"));

  final result =
      await Process.run("ampy", ["-p", port, "ls"], runInShell: true);

  return parseResult(
      result: result,
      onSuccess: (ProcessResult res) {
        LineSplitter ls = LineSplitter();
        List<String> lines = ls.convert(res.stdout);
        return lines;
      },
      onFailure: (ProcessResult res) {
        print(orange("Failed to retrieve files from device"));
        print(orange(res.stderr));

        return tryAgain(
            callback: () => deleteFiles(device: device, port: port));
      });
}
