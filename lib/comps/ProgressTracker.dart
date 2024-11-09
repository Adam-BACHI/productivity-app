import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class ProgressTracker extends StatefulWidget {
  ProgressTracker({super.key});

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
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

  int CatTrack = 0;

  int stepBack(int num) {
    if (num == 0) {
      return db.categories.length - 1;
    } else {
      return num - 1;
    }
  }

  int stepForward(int num) {
    if (num == db.categories.length - 1) {
      return 0;
    } else {
      return num + 1;
    }
  }

  void displayNext() {
    setState(() {
      CatTrack = stepForward(CatTrack);
    });
  }

  void displayPrev() {
    setState(() {
      CatTrack = stepBack(CatTrack);
    });
  }

  double catPercent() {
    String match = db.categories[CatTrack];
    double sum = 0;
    int cpt = 0;

    for (var i = 0; i < db.ToDoList.length; i++) {
      if (db.ToDoList[i][1] == match) {
        cpt++;
        sum = sum + db.ToDoList[i][3];
      }
    }

    return cpt == 0 ? 0.0 : sum / cpt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 336,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your progress',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 252, 252, 253),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: displayPrev,
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color.fromARGB(255, 252, 252, 253),
                      size: 45,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${catPercent().toStringAsFixed(0)}%',
                        style: TextStyle(
                            fontSize: 30,
                            color: catPercent() < 25
                                ? const Color.fromARGB(255, 246, 65, 108)
                                : catPercent() < 50
                                    ? const Color.fromARGB(255, 255, 160, 45)
                                    : catPercent() < 75
                                        ? const Color.fromARGB(
                                            255, 255, 222, 125)
                                        : const Color.fromARGB(
                                            255, 104, 217, 195),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        db.categories[CatTrack],
                        style: TextStyle(
                          fontSize: 15,
                          color: catPercent() < 25
                              ? const Color.fromARGB(255, 246, 65, 108)
                              : catPercent() < 50
                                  ? const Color.fromARGB(255, 255, 160, 45)
                                  : catPercent() < 75
                                      ? const Color.fromARGB(255, 255, 222, 125)
                                      : const Color.fromARGB(
                                          255, 104, 217, 195),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: displayNext,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color.fromARGB(255, 252, 252, 253),
                      size: 45,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
