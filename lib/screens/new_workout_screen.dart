import 'package:flutter/material.dart';
import 'package:fitness_tracker/util/constants.dart';
import 'package:fitness_tracker/services/workout_file_controller.dart';

const List<String> list = <String>['abc', 'def', 'ghi', 'jkl'];

class NewWorkoutScreen extends StatefulWidget {
  @override
  State<NewWorkoutScreen> createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  String dropdownValue = list.first;
  WorkoutFileController newWorkout = WorkoutFileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Workout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              width: double.infinity,
              //height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade700,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: 'Workout Name',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  DropdownButton<String>(
                      value: dropdownValue,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      }),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () async {
                        List<String> testLayout = ['cycling', 'test dummy data', 'reps'];

                        newWorkout.writeNewWorkout(testLayout);

                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.add,
                        color: kAccentColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewWorkout {
  NewWorkout({required this.workoutName, required this.description});
  String workoutName;
  String description;
  List<String> layout = [];
}
