import 'package:dcli/dcli.dart';
import 'package:mpespkit/enums/devices.dart';

Future<String> deviceSelect() async {
  print("Select a Device");
  String device = menu(prompt: "#", options: [Devices.ESP32, Devices.ESP8266]);

  print(blue(device + "\n"));
  return device;
}
