import 'dart:io';
import 'package:dcli/dcli.dart';
import 'dart:async';

Timer killPidTimer(
    {required int pid, required int duration, required String message}) {
  Timer timer = Timer(Duration(seconds: duration), () async {
    print(orange(message));
    await Process.killPid(pid);
  });
  return timer;
}

dynamic parseResult(
    {required ProcessResult result,
    required Function onSuccess,
    required Function onFailure}) {
  if (result.exitCode != 0) return onFailure(result);
  return onSuccess(result);
}

Future<bool> runCommand(
    {String command = "",
    List<String> args = const [],
    bool strict = false,
    bool shell = true,
    String successMsg = "",
    String failureMsg = ""}) async {
  ProcessResult result = await Process.run(command, args, runInShell: shell);
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
