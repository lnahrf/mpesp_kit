import 'package:mpespkit/ampy/delete_files.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

Future<void> deleteTool({required String device, required String port}) async {
  await deleteFiles(device: device, port: port);

  clear();
  return toolsMenu(device: device, port: port);
}
