import 'package:dcli/dcli.dart';

String baudSelect() {
  String baud = ask("Enter transmission speed:",
      defaultValue: "115200", validator: Ask.integer);
  print(blue("Transmission speed set to ${baud} \n"));
  return baud;
}
