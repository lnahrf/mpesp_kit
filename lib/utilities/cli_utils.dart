import "package:dcli/dcli.dart";

void _fallback() {}

void divide() {
  print(" \n");
}

void clear() {
  print("\x1B[2J\x1B[0;0H");
}

void printLogo({bool showSubtitle = true}) {
  print("""                                                        ____________
                                  _    _ _            /. /      / ./\\
                                 | |  (_) |          /. / wifi / ./\\
  _ __ ___  _ __   ___  ___ _ __ | | ___| |_        /. /______/ ./\\
 | '_ ` _ \\| '_ \\ / _ \\/ __| '_ \\| |/ / | __|      /._     __  ./\\
 | | | | | | |_) |  __/\__ \ |  _) |   <| | |_      /.// __ /_/ ./\\
 |_| |_| |_| .__/ \\___||___/ .__/|_|\\_\\_|\\__|    /.    __    ./\\
           | |             | |                  /.___/__/___./\\
           |_|             |_|                  \\            \\
""");
  print("");
  if (showSubtitle) print(blue(getSubtitle()));
  print("");
}

String getSubtitle() {
  return "MicroPython ESP Toolkit, " + getVersion();
}

String getVersion() {
  return "v1.0.0";
}

Future<void> tryAgain(
    {required Function callback,
    Function exit = _fallback,
    String message = "Try again?"}) async {
  bool retry = confirm(message);
  if (retry) return callback();
  return exit();
}
