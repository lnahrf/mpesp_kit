import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/utilities/parse_result.dart';

Future runCommand(
    {String command = "",
    List<String> args = const [],
    bool strict = false,
    bool shell = true,
    String successMsg = "",
    String failureMsg = ""}) async {
  final result = await Process.run(command, args, runInShell: shell);
  return parseResult(
      result: result,
      onSuccess: (ProcessResult res) {
        if (successMsg != "") print(green(successMsg));
        return true;
      },
      onFailure: (ProcessResult res) {
        if (failureMsg != "") print(orange(failureMsg));
        print(orange(res.stderr != "" ? res.stderr : res.stdout));
        if (strict) throw Exception(res.stderr != "" ? res.stderr : res.stdout);
        return false;
      });
}
