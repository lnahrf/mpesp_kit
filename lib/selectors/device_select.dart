import 'package:dcli/dcli.dart';
import 'package:mpespkit/enums/devices.dart';

Future<String> deviceSelect() async {
  List<Device> devices = [Devices.ESP32];

  if (devices.length == 1) {
    return devices[0].name;
  }

  print("Select a Device");

  Device device = menu(
      prompt: "#",
      options: devices,
      format: (device) {
        if (device.info != null) return "${device.name} - ${device.info}";
        return device.name;
      });

  print(blue(device.name + "\n"));
  return device.name;
}
