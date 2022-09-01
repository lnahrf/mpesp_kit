import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:mpespkit/ampy/select_transfer_files.dart';
import 'package:mpespkit/ampy/transfer_files.dart';
import 'package:mpespkit/utilities/cli_utils.dart';
import 'package:mpespkit/utilities/tools_menu.dart';

Future<void> transferTool(
    {required String device, required String port}) async {
  List<File> files = await selectTransferFiles();

  if (files.length > 0) {
    await transferFiles(
        device: device,
        port: port,
        paths: files.map((file) => file.path).toList());
  } else {
    print(orange("No files selected"));
  }

  sleep(1);

  clear();
  return toolsMenu(device: device, port: port);
}
