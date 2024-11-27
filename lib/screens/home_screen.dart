import 'package:fitness_tracker/services/workout_file_controller.dart';
import 'package:fitness_tracker/widgets/page_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:fitness_tracker/util/constants.dart';
import 'package:fitness_tracker/screens/workout_screen.dart';
import 'package:fitness_tracker/screens/new_workout_screen.dart';
import 'package:fitness_tracker/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> workoutButtons = [];

  Future<List<Widget>> getWorkoutButtons() async {
    List<String> workoutNames = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList('workouts', <String>['pullups', 'pushups', 'squats']);
    workoutNames = prefs.getStringList('workouts')!;
    workoutButtons.clear();
    for (int i = 0; i < workoutNames.length; i++) {
      workoutButtons.add(DummyButton(name: workoutNames[i]));
    }
    return workoutButtons;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserProfileScreen();
                }));
              },
              child: Icon(
                Icons.account_circle,
                color: kAccentColor,
              ))
        ],
      ),
      body: FutureBuilder<List<Widget>>(
        future: getWorkoutButtons(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  PageBodyWidget(
                    childWidget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text(
                              'Workouts',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 24, right: 24),
                          children: workoutButtons,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return NewWorkoutScreen();
                                  })).then((_) => setState(() {}));
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
                  PageBodyWidget(
                    childWidget: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text(
                              'Schedule',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Fitness Tracker'),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                 return UserProfileScreen();
  //               }));
  //             },
  //             child: Icon(
  //               Icons.account_circle,
  //               color: kAccentColor,
  //             ))
  //       ],
  //     ),
  //     body: FutureBuilder<List<Widget>>(
  //       future: getWorkoutButtons(),
  //       builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           return GridView.count(
  //             crossAxisCount: 3,
  //             shrinkWrap: true,
  //             padding: EdgeInsets.only(left: 24, right: 24),
  //             children: snapshot.data!,
  //           );
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //   },
  //
  //   );
  // }
}

class DummyButton extends StatelessWidget {
  String name;
  DummyButton({
    required this.name,
  });



  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          WorkoutFileController workoutFileController = WorkoutFileController();
          workoutFileController.readData();
          return WorkoutScreen(
            workoutName: name,
            workoutFileController: workoutFileController,
          );
        }));
      },
      child: Container(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.cyan.shade600,
        ),
      ),
    );
  }
}


