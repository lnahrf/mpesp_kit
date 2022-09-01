import 'dart:io';
import 'package:dcli/dcli.dart';

Future<String> portSelect() async {
  String separationString = "_mpespkit_separation_";

  ProcessResult result = await Process.run(
      "python",
      [
        "-c",
        "import serial.tools.list_ports as serial_ports; import sys; sys.stdout.write(' '.join([f'{p.device} - {p.description}${separationString}' for p in serial_ports.comports()]))"
      ],
      runInShell: true);

  if (result.stderr != "") throw Exception("Could not find Serial Ports");

  List<String> coms = [];
  for (String com in result.stdout.split(separationString))
    coms.add(com.trim());
  coms.removeWhere((com) => ["", null, false, 0].contains(com));

  if (coms.length == 0) throw Exception("Could not find Serial Ports");

  print("Select a Serial Port");
  String port = menu(prompt: "#", options: coms);
  String portAbbr = port.split(' - ')[0];
  print(blue(portAbbr + "\n"));
  sleep(1);

  return portAbbr;
}
