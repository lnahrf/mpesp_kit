import 'package:dcli/dcli.dart';
import 'package:mpespkit/selectors/tool_select.dart';
import 'package:mpespkit/tools/flash_tool.dart';
import 'package:mpespkit/tools/delete_tool.dart';
import 'package:mpespkit/tools/serial_shell_tool.dart';
import 'package:mpespkit/tools/soft_reset_tool.dart';
import 'package:mpespkit/tools/transfer_tool.dart';
import 'package:mpespkit/utilities/cli_utils.dart';

Future<void> toolsMenu({required String device, required String port}) async {
  print(blue(getSubtitle()));

  final selectedTool = await toolSelect();

  switch (selectedTool) {
    case "Flash":
      await flashTool(device: device, port: port);
      break;
    case "Transfer":
      await transferTool(device: device, port: port);
      break;
    case "Delete":
      await deleteTool(device: device, port: port);
      break;
    case "Soft Reset":
      await softResetTool(device: device, port: port);
      break;
    case "Serial Shell":
      serialShellTool(device: device, port: port);
      break;
  }
}
