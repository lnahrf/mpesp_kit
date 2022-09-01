import 'package:dcli/dcli.dart';
import 'package:mpespkit/enums/tools.dart';

Future<String> toolSelect(
    {required String device, required String port}) async {
  print("Select a Tool " + green("(${device}:${port})"));

  Tool tool = menu(
      prompt: "#",
      options: [
        Tools.Flash,
        Tools.Transfer,
        Tools.FileList,
        Tools.Delete,
        Tools.SoftReset,
      ],
      format: (tool) => "${tool.name} - ${tool.description}");

  print(blue("\n" + tool.name + "\n"));
  sleep(1);

  return tool.name.split(' - ')[0];
}
