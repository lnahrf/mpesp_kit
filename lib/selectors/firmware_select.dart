import 'package:dcli/dcli.dart';
import 'dart:io';

import 'package:mpespkit/enums/operating_systems.dart';
import 'package:mpespkit/utilities/os_utils.dart';

Future<dynamic> firmwareSelect({required String device}) async {
  bool cont = confirm("Flash new firmware on to the device?");
  if (!cont) return;

  String URL = ask(
    "Enter MicroPython's firmware URL (https://micropython.org/download/) or an absolute path to the local .bin file:",
  );

  if (URL.startsWith("\"") && URL.endsWith("\""))
    URL = URL.substring(1, URL.length - 1);

  if (URL.startsWith("https://"))
    return _downloadFirmware(URL: URL, device: device);
  return _loadLocalFirmware(path: URL, device: device);
}

Future<dynamic> _downloadFirmware(
    {required String URL, required String device}) async {
  try {
    if (!URL.endsWith(".bin"))
      throw Exception(
          "Bad URL, MicroPython's firmware URL should end with .bin");

    print(blue("Downloading firmware... \n"));

    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(URL));
    HttpClientResponse response = await request.close();

    String pathDivider =
        compareOS(OperatingSystems.LINUX) || compareOS(OperatingSystems.MACOS)
            ? '/'
            : '\\';

    File firmware = File(Directory.systemTemp.path +
        pathDivider +
        "mpespkit_firmware_${new DateTime.now().toIso8601String().replaceAll(":", "_").replaceAll(".", "_")}.bin");

    await response.pipe(firmware.openWrite());
    return firmware;
  } catch (exception) {
    print(orange("Failed to download firmware from ${URL}"));
    print(orange(exception.toString()));
    return firmwareSelect(device: device);
  }
}

Future<dynamic> _loadLocalFirmware(
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
