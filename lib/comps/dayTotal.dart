import 'package:flutter/material.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class DayTotal extends StatefulWidget {
  final DateTime date;
  DayTotal({super.key, required this.date});

  @override
  State<DayTotal> createState() => _DayTotalState();
}

class _DayTotalState extends State<DayTotal> {
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

    for (var i = 0; i < ToDoList.length; i++) {
      if (ToDoList[i][2].day == day.day &&
          ToDoList[i][2].month == day.month &&
          ToDoList[i][2].year == day.year) {
        sum = sum + ToDoList[i][3];
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
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w300, fontFamily: 'Open'),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 50, 60, 72),
              ),
              width: 350,
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: dayProgress(widget.date) < 25
                    ? Color.fromARGB(255, 246, 65, 108)
                    : dayProgress(widget.date) < 50
                        ? Color.fromARGB(255, 255, 160, 45)
                        : dayProgress(widget.date) < 75
                            ? Color.fromARGB(255, 255, 222, 125)
                            : Color.fromARGB(255, 104, 217, 195),
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
