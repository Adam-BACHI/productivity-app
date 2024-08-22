import 'package:flutter/material.dart';
import 'package:productivity_app/comps/percentTask.dart';

class ProgressTracker extends StatefulWidget {
  const ProgressTracker({super.key});

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          width: 336,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Votre progrès',
                style: TextStyle(
                  fontFamily: 'Open',
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 252, 252, 253),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '60%',
                            style: TextStyle(
                                fontFamily: 'Open',
                                fontSize: 30,
                                color: Color.fromARGB(255, 252, 252, 253),
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: Color.fromARGB(255, 252, 252, 253),
                              ),
                              Text(
                                'toutes les taches',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'Open',
                                  color: Color.fromARGB(255, 252, 252, 253),
                                ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: Color.fromARGB(255, 252, 252, 253),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        percentTask(),
                        percentTask(),
                        percentTask(),
                      ],
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
