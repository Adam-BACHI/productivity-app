import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/dayTotal.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class Week extends StatefulWidget {
  const Week({super.key});

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
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

  String dateToWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "lundi";
      case 2:
        return "mardi";
      case 3:
        return "mercredi";
      case 4:
        return "jeudi";
      case 5:
        return "vendredi";
      case 6:
        return "samedi";
      case 7:
        return "dimanche";

      default:
        return "";
    }
  }

  DateTime begOfWeek() {
    DateTime? firstSun;

    int i = 0;
    firstSun = DateTime.now();

    while (
        dateToWeek(DateTime.now().subtract(Duration(days: i))) != "dimanche") {
      i++;
      firstSun = DateTime.now().subtract(Duration(days: i));
    }

    return firstSun!;
  }

  void progressChanged(double value, int ind) {
    setState(() {
      db.ToDoList[db.ToDoList.length - ind - 1][3] = value;
    });
    db.UpdateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 26, 39),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(top: 80, left: 30),
          child: Text(
            'Bilan de la semaine',
            style: TextStyle(
              fontSize: 26,
              color: Color.fromARGB(255, 252, 252, 253),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: DayTotal(date: begOfWeek().add(Duration(days: i))),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
