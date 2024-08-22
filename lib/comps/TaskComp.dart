import 'package:flutter/material.dart';

class TaskComp extends StatefulWidget {
  const TaskComp({super.key});

  @override
  State<TaskComp> createState() => _TaskCompState();
}

class _TaskCompState extends State<TaskComp> {
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
          child: const Column(
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
                          'Task Name',
                          style: TextStyle(
                              fontFamily: 'Open',
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 253, 253, 252)),
                        ),
                        Text(
                          'Folder',
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
                            'dd/dd/dddd',
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
