import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class DaySquare extends StatefulWidget {
  final DateTime date;
  const DaySquare({super.key, required this.date});

  @override
  State<DaySquare> createState() => _DaySquareState();
}

class _DaySquareState extends State<DaySquare> {
  DataBase db = DataBase();
  final _myBase = Hive.box("TaskBase");

  @override
  void initState() {
    //if it's the first time the app is launched
    //then crate Default list
    if (_myBase.get("TODOLIST") == null) {
      db.DefaultData();
    } else {
      db.LoadData();
    }

    db.UpdateData();

    super.initState();
  }

  int dayProgress(DateTime day) {
    double sum = 0;
    double cpt = 0;

    for (var i = 0; i < db.ToDoList.length; i++) {
      if (db.ToDoList[i][5].day == day.day &&
          db.ToDoList[i][5].month == day.month &&
          db.ToDoList[i][5].year == day.year) {
        sum = sum + db.ToDoList[i][3];
        cpt++;
      }
    }
    return cpt == 0 ? 0 : sum ~/ cpt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: dayProgress(widget.date) < 10
              ? const Color.fromARGB(25, 104, 217, 195)
              : Color.fromARGB((dayProgress(widget.date) * 255 / 100).toInt(),
                  104, 217, 195),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
