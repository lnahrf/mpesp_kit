import 'package:mpespkit/ampy/soft_reset.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

Future<void> softResetTool(
    {required String device, required String port}) async {
  await softReset(device: device, port: port);

  clear();
  return toolsMenu(device: device, port: port);
}
