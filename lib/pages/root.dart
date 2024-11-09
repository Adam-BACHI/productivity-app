import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/dataBase/TaskList.dart';
import 'package:productivity_app/pages/TaskCategories.dart';
import 'package:productivity_app/pages/heatMap.dart';
import 'package:productivity_app/pages/home.dart';
import 'package:productivity_app/pages/weekBilan.dart';
import 'dart:async';

class Root extends StatefulWidget {
  Root({super.key});

  @override
  State<Root> createState() => _WelcomeState();
}

class _WelcomeState extends State<Root> {
  DataBase db = DataBase();
  final _myBase = Hive.box("TaskBase");
  Timer? _timer;

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
    _timer = Timer.periodic(Duration(minutes: 5), (Timer timer) {
      checkForNotifications();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  PageController _Pagecontroller = PageController();
  final _controller = TextEditingController();
  int _selectedIndex = 0;

  void progressChanged(double value, int ind) {
    setState(() {
      db.ToDoList[db.ToDoList.length - ind - 1][3] = value;
    });
    db.UpdateData();
  }

  String _dropValue = "unclassified";
  TimeOfDay _time = TimeOfDay.now();

  void _save() {
    setState(() {
      db.ToDoList.add([
        _controller.text,
        _dropValue,
        "${_time.hour}:${_time.minute}",
        0.0,
        false,
        DateTime.now()
      ]);
    });
    Navigator.of(context).pop();
    _controller.clear();
    db.UpdateData();
  }

  void _cancel() {
    Navigator.of(context).pop();
    _controller.clear();
    db.UpdateData();
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
          onTimeSelection: (Time) {
            setState(() {
              _time = Time;
            });
          },
        );
      },
    );
    db.UpdateData();
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    db.UpdateData();
  }

  triggerNot(int j) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: "Basic_channel",
            title: "You have a task to complete!",
            body: "${db.ToDoList[j][0]}, by ${db.ToDoList[j][2]}"));
  }

  TimeOfDay covertToTime(String time) {
    TimeOfDay result;
    int hour = 0;
    int minute = 0;
    int i = 0;

    while ((time[i] != ":")) {
      hour = hour * 10 + int.parse(time[i]);
      i++;
    }

    i++;

    while (i < time.length) {
      minute = minute * 10 + int.parse(time[i]);
      i++;
    }

    result = TimeOfDay(hour: hour, minute: minute);

    return result;
  }

  DateTime convertToDate(TimeOfDay time) {
    final now = DateTime.now();
    DateTime result =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    return result;
  }

  checkForNotifications() {
    int i = 0;
    DateTime checkTime;

    while ((i < db.ToDoList.length) &&
        (db.ToDoList[i][5].day != DateTime.now().day ||
            db.ToDoList[i][5].month != DateTime.now().month ||
            db.ToDoList[i][5].year != DateTime.now().year)) {
      i++;
    }

    while (i < db.ToDoList.length) {
      checkTime = convertToDate(covertToTime(db.ToDoList[i][2]));

      final diff = checkTime.difference(DateTime.now());

      if ((diff.inMinutes > 0) &&
          (diff.inMinutes < 15) &&
          (db.ToDoList[i][3] != 100)) {
        triggerNot(i);
      }
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 26, 39),
        body: Stack(
          children: [
            PageView(
              controller: _Pagecontroller,
              onPageChanged: onPageChanged,
              children: [
                // DIFFERENT PAGES

                HomePage(),
                TaskCat(),
                Week(),
                HeatMapPage()
              ],
            ),

            //LOGO IMAGE
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('lib/images/LOGO-nav.png'),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 34, 40, 49),
            onPressed: createTask,
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 0, 184, 169),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: GNav(
            gap: 8,
            color: const Color.fromARGB(255, 252, 252, 253),
            activeColor: const Color.fromARGB(255, 0, 184, 169),
            tabBackgroundColor: const Color.fromARGB(255, 34, 40, 49),
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                _Pagecontroller.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'main',
              ),
              GButton(
                icon: Icons.folder,
                text: 'all tasks',
              ),
              GButton(
                icon: Icons.date_range_sharp,
                text: 'week summary',
              ),
              GButton(
                icon: Icons.grid_view_rounded,
                text: 'heatmap',
              ),
            ],
          ),
        ));
  }
}
