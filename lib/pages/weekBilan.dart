import 'package:flutter/material.dart';
import 'package:productivity_app/comps/dayTotal.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/dataBase/TaskList.dart';
import 'package:productivity_app/pages/TaskCategories.dart';
import 'package:productivity_app/pages/home.dart';

class Week extends StatefulWidget {
  const Week({super.key});

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  final _controller = TextEditingController();

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
      ToDoList[ToDoList.length - ind - 1][3] = value;
    });
  }

  String _dropValue = "categorie";
  DateTime _date = DateTime.now();

  void _save() {
    setState(() {
      ToDoList.add([_controller.text, _dropValue, _date, 0.0]);
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void _cancel() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return NewTask(
          controller: _controller,
          save: _save,
          cancel: _cancel,
          onDropValueChanged: (newValue) {
            setState(() {
              _dropValue = newValue;
            });
          },
          onDateSelection: (date) {
            setState(() {
              _date = date;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 26, 39),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/images/LOGO-nav.png',
                width: 90,
              ),
              const Icon(
                Icons.menu,
                size: 29,
                color: Color.fromARGB(255, 0, 184, 169),
              ),
            ],
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            'Bilan de la semaine',
            style: TextStyle(
              fontFamily: 'Open',
              fontSize: 26,
              color: Color.fromARGB(255, 252, 252, 253),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: DayTotal(date: begOfWeek().add(Duration(days: i))),
                );
              },
            ),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 34, 40, 49),
        onPressed: createTask,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 184, 169),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 0, 184, 169),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TaskCat();
                  }));
                },
                icon: Icon(
                  Icons.folder,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.grid_3x3,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Week();
                  }));
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 34, 40, 49),
                ))
          ],
        ),
      ),
    );
  }
}
