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
