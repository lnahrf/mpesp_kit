import 'dart:io';
import 'dart:convert';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/process_utils.dart';

Future<dynamic> getFiles({required String device, required String port}) async {
  print(blue("Retreiving file list (this may take a while) \n"));

  ProcessResult result =
      await Process.run("ampy", ["-p", port, "ls"], runInShell: true);

  return parseResult(
      result: result,
      onSuccess: (ProcessResult res) {
        LineSplitter ls = LineSplitter();
        List<String> lines = ls.convert(res.stdout);

        print(blue("Files:"));
        for (int i = 0; i < lines.length; i++)
          print(blue(i == lines.length - 1 ? lines[i] + "\n" : lines[i]));

        return lines;
      },
      onFailure: (ProcessResult res) {
        print(orange("Failed to retrieve files from device"));
        print(orange(res.stderr ? res.stderr : res.stdout));

        return tryAgain(callback: () => getFiles(device: device, port: port));
      });
}
