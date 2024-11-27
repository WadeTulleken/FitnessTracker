import 'package:flutter/material.dart';
import 'package:fitness_tracker/services/workout_file_controller.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({required this.workoutName, required this.workoutFileController});
  String workoutName;
  WorkoutFileController workoutFileController;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    //widget.workoutFileController.readData();
    List<List<String>> newContents = widget.workoutFileController.newContents;
    String layout = widget.workoutFileController.layout;

    DataTable workoutDataTable() {
      List<DataColumn> columnData = [DataColumn(label: Text('test column heading'))];
      List<DataRow> rowData = [];
      List<DataCell> cellData = [];
      final layoutSplit = layout.split(',');
      for (int l = 0; l < layoutSplit.length; l++) {
        columnData.add(DataColumn(
            label: Expanded(
                child: Text(
          layoutSplit[l],
          style: TextStyle(fontStyle: FontStyle.italic),
        ))));
      }
      for (int r = 0; r < newContents.length; r++) {
        cellData.clear();
        for (int d = 0; d < layoutSplit.length; d++) {
          cellData.add(DataCell(Text(newContents[r][d])));
        }
        rowData.add(DataRow(cells: cellData));
      }
      DataTable workoutData = DataTable(columns: columnData, rows: rowData);
      return workoutData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              height: 50,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Progress',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                //height: 400,
                width: 400,
                child: workoutDataTable()),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final dynamic x;
  final dynamic y;
}
