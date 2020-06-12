import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {

  final String fileName;

  FileManager({
    this.fileName
  });

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  void writeFile(List<String> contents) async {
    File file = await localFile;
    for (int i = 0; i < contents.length; ++i) {
      await file.writeAsString(contents[i] + '\n', mode: FileMode.append);
    }
  }

  Future<List<String>> readFile() async {
    File file = await localFile;
    List<String> previousEntries = await file.readAsLines();
    for (var entry in previousEntries) {
      print(entry);
    }
    return previousEntries;
  }

  void deleteFile() async {
    File file = await localFile;
    file.deleteSync();
  }
}