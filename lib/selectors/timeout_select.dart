import 'package:dcli/dcli.dart';

String timeoutSelect() {
  String timeout = ask("Enter timeout in seconds",
      defaultValue: "30", validator: Ask.integer);
  print(blue("Timeout is set to ${timeout} seconds \n"));
  return timeout;
}
