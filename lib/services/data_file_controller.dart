import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

class DataFileController {
  //String? _content;
  //Future<List<String>>? _content;

  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> readData() async {
    final dirPath = await _getDirPath();
    final myFile = await File('$dirPath/pullups.csv');
    final fileContents = myFile.readAsLines(encoding: utf8);
    //final data = await myFile.readAsString(encoding: utf8);
    List<String> contents = await fileContents;
    String layout = contents[0];
    contents.removeAt(0);
    print(layout);
    for (int i = 0; i < contents.length; i++) {
      print(contents[i]);
    }
  }

}