import 'package:dcli/dcli.dart';
import 'dart:io';

Future<dynamic> firmwareSelect({required String device}) async {
  bool cont = confirm("Continue to flash new firmware on to your device?");
  if (!cont) return;

  final URL = ask(
    "Enter MicroPython's firmware URL (https://micropython.org/download/) or an absolute path to the local .bin file:",
  );

  if (URL.startsWith("https://"))
    return downloadFirmware(URL: URL, device: device);
  return loadLocalFirmware(path: URL, device: device);
}

Future<dynamic> downloadFirmware(
    {required String URL, required String device}) async {
  try {
    if (!URL.endsWith(".bin"))
      throw Exception(
          "Bad URL, MicroPython's firmware URL should end with .bin");

    print(blue("Downloading firmware..."));

    final request = await HttpClient().getUrl(Uri.parse(URL));
    final response = await request.close();
    File firmware = File(Directory.systemTemp.path +
        "\\msespkit_firmware_${new DateTime.now().toIso8601String().replaceAll(":", "_").replaceAll(".", "_")}.bin");
    await response.pipe(firmware.openWrite());
    return firmware;
  } catch (exception) {
    print(orange("Failed to download firmware from ${URL}"));
    print(orange(exception.toString()));
    return firmwareSelect(device: device);
  }
}

Future<dynamic> loadLocalFirmware(
    {required String path, required String device}) async {
  try {
    File firmware = File(path);
    bool exists = await firmware.exists();
    if (!exists) throw Exception("Failed to load local firmware from ${path}");
    print(blue(firmware.path));
    return firmware;
  } catch (exception) {
    print(orange(exception.toString()));
    return firmwareSelect(device: device);
  }
}
