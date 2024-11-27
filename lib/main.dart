import 'package:fitness_tracker/services/workout_file_controller.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/data_file_controller.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkoutFileController workoutFileController = WorkoutFileController();
    //workoutFileController.readData();
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
