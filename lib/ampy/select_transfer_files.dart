import 'dart:io';
import 'package:dcli/dcli.dart';

Future<List<File>> selectTransferFiles() async {
  List<File> files = [];
  final firstFile = await addFile();

  if (firstFile != null) files.add(firstFile);

  bool shouldAddAnotherFile = confirm("Add another file?");

  while (shouldAddAnotherFile) {
    final loopFile = await addFile();

    bool isNull = loopFile == null;

    if (isNull) {
      shouldAddAnotherFile = confirm("Add another file?");
      continue;
    }

    bool isDuplicate =
        files.any((item) => item.path == (loopFile as File).path);

    if (!isNull && !isDuplicate)
      files.add(loopFile);
    else if (isDuplicate) print(orange("File is a duplicate, skipping"));

    shouldAddAnotherFile = confirm("Add another file?");
  }

  print(blue("\nSelected files:"));
  for (int i = 0; i < files.length; i++)
    print(blue(i == files.length - 1 ? files[i].path + "\n" : files[i].path));

  return files;
}

Future<dynamic> addFile() async {
  final path = ask(
      "Enter the filepath you would like to transfer to MicroPython's file system:");
  File file = File(path);
  try {
    bool exists = await file.exists();
    if (!exists) throw Exception("Could not find ${path}");
  } catch (exception) {
    print(orange(exception.toString()));
    return null;
  }
  print(blue(file.path + "\n"));
  return file;
}
