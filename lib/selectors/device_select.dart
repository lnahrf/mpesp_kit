import 'package:dcli/dcli.dart';
import 'package:mpespkit/enums/devices.dart';

Future<String> deviceSelect() async {
  print("Select a Device");
  final device = menu(prompt: "#", options: [Devices.ESP32, Devices.ESP8622]);

  print(blue(device + "\n"));
  sleep(1);
  return device;
}
