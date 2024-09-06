import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class DayTotal extends StatefulWidget {
  final DateTime date;
  const DayTotal({super.key, required this.date});

  @override
  State<DayTotal> createState() => _DayTotalState();
}

class _DayTotalState extends State<DayTotal> {
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

  double dayProgress(DateTime day) {
    double sum = 0;
    int cpt = 0;

    for (var i = 0; i < db.ToDoList.length; i++) {
      if (db.ToDoList[i][2].day == day.day &&
          db.ToDoList[i][2].month == day.month &&
          db.ToDoList[i][2].year == day.year) {
        sum = sum + db.ToDoList[i][3];
        cpt++;
      }
    }
    return cpt == 0 ? 0.0 : sum / cpt;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateToWeek(widget.date),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 50, 60, 72),
              ),
              width: 350,
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: dayProgress(widget.date) < 25
                    ? const Color.fromARGB(255, 246, 65, 108)
                    : dayProgress(widget.date) < 50
                        ? const Color.fromARGB(255, 255, 160, 45)
                        : dayProgress(widget.date) < 75
                            ? const Color.fromARGB(255, 255, 222, 125)
                            : const Color.fromARGB(255, 104, 217, 195),
              ),
              width: (dayProgress(widget.date) / 100) * 350,
              height: 30,
            )
          ],
        )
      ],
    );
  }
}
