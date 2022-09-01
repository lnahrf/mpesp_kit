abstract class Devices {
  static final Device ESP32 = Device(name: "esp32");
  static final Device ESP8266 =
      Device(name: "esp8266", info: "(Partially supported)");
}

class Device {
  String name;
  String? info;

  Device({required this.name, this.info});
}
