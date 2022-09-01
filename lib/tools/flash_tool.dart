import 'package:mpespkit/esptool/erase_flash.dart';
import 'package:mpespkit/esptool/flash_firmware.dart';
import 'package:mpespkit/selectors/firmware_select.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

Future<void> flashTool({required String device, required String port}) async {
  await eraseFlash(device: device, port: port);
  final firmware = await firmwareSelect(device: device);
  if (firmware != null)
    await flashFirmware(device: device, port: port, firmware: firmware);

  clear();
  return toolsMenu(device: device, port: port);
}
