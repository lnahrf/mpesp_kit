import 'package:dcli/dcli.dart';

import 'package:mpespkit/config/ampy_init.dart';
import 'package:mpespkit/config/esptool_init.dart';
import 'package:mpespkit/config/python_init.dart';

import 'package:mpespkit/selectors/port_select.dart';
import 'package:mpespkit/selectors/device_select.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

/**
 * TODO:
 * - Organize code and try to separate rendering and logic as much as possible
 * - remove all final types
 * - finish Serial Shell Tool
 * - add baud selector on file transfer
 * - support "path" on file transfer
 * - Improve UX on all tools
 * - Write a readme
 */

void main(List<String> arguments) async {
  printLogo(false);
  print(blue("Author: ") + white("https://github.com/tk-ni"));
  print(blue("Repository: ") + white("https://github.com/tk-ni/mpespkit"));
  print(blue("Starting ${getSubtitle()}... \n"));

  sleep(1);
  await pythonInit();
  await esptoolInit();
  await ampyInit();

  final selectedDevice = await deviceSelect();
  final selectedPort = await portSelect();

  clear();
  await toolsMenu(device: selectedDevice, port: selectedPort);
}
