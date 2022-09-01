import 'package:mpespkit/ampy/get_files.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

Future<void> fileListTool(
    {required String device, required String port}) async {
  await getFiles(device: device, port: port);

  return tryAgain(
      callback: () {
        clear();
        fileListTool(device: device, port: port);
      },
      exit: () {
        clear();
        toolsMenu(device: device, port: port);
      },
      message: "List again?");
}
