import 'package:dcli/dcli.dart';

String baudSelect() {
  String baud = ask("Enter transmission speed (bps)",
      defaultValue: "115200", validator: Ask.integer);
  print(blue("Transmission speed set to ${baud}bps \n"));
  return baud;
}
