import 'package:dcli/dcli.dart';

import 'package:mpespkit/config/ampy_init.dart';
import 'package:mpespkit/config/esptool_init.dart';
import 'package:mpespkit/config/python_init.dart';

import 'package:mpespkit/selectors/port_select.dart';
import 'package:mpespkit/selectors/device_select.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

void main(List<String> arguments) async {
  printLogo();
  print(blue("Repository: ") + white("https://github.com/tk-ni/mpespkit"));
  print(blue("Starting ${getSubtitle()}... \n"));

  sleep(1);
  await pythonInit();
  await esptoolInit();
  await ampyInit();

  String selectedDevice = await deviceSelect();
  String selectedPort = await portSelect();

  clear();
  await toolsMenu(device: selectedDevice, port: selectedPort);
}
