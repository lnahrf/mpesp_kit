import 'package:dcli/dcli.dart';

void _fallback() {}

Future<void> tryAgain(
    {required Function callback, Function exit = _fallback}) async {
  bool retry = confirm("Try again?");
  if (retry) return callback();
  return exit();
}
