import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutFileController {
  String? stringContent;
  Future<List<String>>? _content;
  String layout = '';
  List<List<String>> newContents = [];

  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> readData() async {
    final dirPath = await _getDirPath();
    final myFile = await File('$dirPath/pullups.csv');
    final fileContents = myFile.readAsLines(encoding: utf8);
    stringContent = await myFile.readAsString(encoding: utf8);
    List<String> contents = await fileContents;
    layout = contents[0];
    contents.removeAt(0);
    newContents.clear();
    for (int i = 0; i < contents.length; i++) {
      final split = contents[i].split(',');
      //print(split);
      newContents.add(split);
    }
  }

  Future<void> writeNewWorkout(List<String> layout) async {
    String workoutName = layout[0];
    final dirPath = await _getDirPath();

    if (await File('$dirPath/$workoutName.csv').exists()) {
      throw 'File already exists';
    } else {
      await File('$dirPath/$workoutName.csv').create(recursive: true);
      final myFile = File('$dirPath/$workoutName.csv');
      String layoutString = '';
      for (int i = 0; i < layout.length; i++) {
        if (i < layout.length - 1) {
          layoutString += '${layout[i]}, ';
        } else {
          layoutString += layout[i];
        }
      }
      List<String> workoutNames = [];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      workoutNames = prefs.getStringList('workouts')!;
      workoutNames.add(workoutName);
      await prefs.setStringList('workouts', workoutNames);
      await myFile.writeAsString(layoutString);
    }
  }
  // String? _content;
  // // Find the Documents path
  // Future<String> _getDirPath() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   return dir.path;
  // }
  // // This function is triggered when the "Read" button is pressed
  // Future<void> readData() async {
  //   final dirPath = await _getDirPath();
  //   final myFile = await File('$dirPath/test.csv');
  //   final data = await myFile.readAsString(encoding: utf8);
  //   _content = data;
  //   print(dirPath);
  //   print(_content);
  // }
  // // This function is triggered when the "Write" button is pressed
  // Future<void> writeData() async {
  //   File? myFile;
  //   final dirPath = await _getDirPath();
  //
  //   if (await File('$dirPath/test.csv').exists()) {
  //     final myFile = File('$dirPath/test.csv');
  //   } else {
  //     final myFile = await new File('$dirPath/test.csv').create(recursive: true);
  //   }
  //   // If data.txt doesn't exist, it will be created automatically
  //
  //   await myFile?.writeAsString('new test string to be read');
  // }
}
