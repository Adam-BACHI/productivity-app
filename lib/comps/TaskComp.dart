import 'package:flutter/material.dart';

class TaskComp extends StatelessWidget {
  final String taskName;
  final String category;
  final DateTime date;

  const TaskComp(
      {super.key,
      required this.taskName,
      required this.category,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 336,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 34, 40, 49),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskName,
                          style: TextStyle(
                              fontFamily: 'Open',
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 253, 253, 252)),
                        ),
                        Text(
                          category,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Open',
                              color: Color.fromARGB(255, 253, 253, 252)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            date.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: 'Open',
                              color: Color.fromARGB(255, 188, 196, 207),
                            ),
                          ),
                        ),
                        Text(
                          '2 jours restants',
                          style: TextStyle(
                            fontFamily: 'Open',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color.fromARGB(255, 188, 196, 207),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 25),
                  child: SizedBox(
                      height: 10.0,
                      width: 200.0,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromARGB(255, 255, 222, 125)),
                        backgroundColor: Color.fromARGB(255, 50, 60, 72),
                        value: 0.5,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
