import 'package:flutter/material.dart';
import 'package:productivity_app/dataBase/Categories.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class ProgressTracker extends StatefulWidget {
  const ProgressTracker({super.key});

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  int CatTrack = 0;

  int stepBack(int num) {
    if (num == 0) {
      return categories.length - 1;
    } else {
      return num - 1;
    }
  }

  int stepForward(int num) {
    if (num == categories.length - 1) {
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
    String match = categories[CatTrack];
    double sum = 0;
    int cpt = 0;

    for (var i = 0; i < ToDoList.length; i++) {
      if (ToDoList[i][1] == match) {
        cpt++;
        sum = sum + ToDoList[i][3];
      }
    }

    return cpt == 0 ? 0.0 : sum / cpt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          width: 336,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Votre progrès',
                style: TextStyle(
                  fontFamily: 'Open',
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 252, 252, 253),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color.fromARGB(255, 252, 252, 253),
                        size: 45,
                      ),
                      onTap: displayPrev,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${catPercent().toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontFamily: 'Open',
                              fontSize: 30,
                              color: catPercent() < 25
                                  ? Color.fromARGB(255, 246, 65, 108)
                                  : catPercent() < 50
                                      ? Color.fromARGB(255, 255, 160, 45)
                                      : catPercent() < 75
                                          ? Color.fromARGB(255, 255, 222, 125)
                                          : Color.fromARGB(255, 104, 217, 195),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${categories[CatTrack]}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Open',
                            color: catPercent() < 25
                                ? Color.fromARGB(255, 246, 65, 108)
                                : catPercent() < 50
                                    ? Color.fromARGB(255, 255, 160, 45)
                                    : catPercent() < 75
                                        ? Color.fromARGB(255, 255, 222, 125)
                                        : Color.fromARGB(255, 104, 217, 195),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromARGB(255, 252, 252, 253),
                        size: 45,
                      ),
                      onTap: displayNext,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
