import 'package:dcli/dcli.dart';
import 'package:mpespkit/enums/tools.dart';

Future<String> toolSelect() async {
  print("Select a Tool");
  final tool = menu(
      prompt: "#",
      options: [
        Tools.Flash,
        Tools.Transfer,
        Tools.Delete,
        Tools.SoftReset,
        Tools.Serial
      ],
      format: (tool) => "${(tool as Tool).name} - ${tool.description}");

  print(blue("\n" + tool.name + "\n"));
  sleep(1);

  return tool.name.split(' - ')[0];
}
