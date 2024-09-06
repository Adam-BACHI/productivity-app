import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskComp extends StatefulWidget {
  final String taskName;
  final String category;
  final DateTime date;
  final ValueChanged onProgressChanged;
  final double progress;
  final Function(BuildContext)? delTask;

  TaskComp({
    super.key,
    required this.taskName,
    required this.category,
    required this.date,
    required this.onProgressChanged,
    required this.progress,
    required this.delTask,
  });

  @override
  State<TaskComp> createState() => _TaskCompState();
}

class _TaskCompState extends State<TaskComp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: const Color.fromARGB(255, 18, 26, 39),
                content: Container(
                  height: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.taskName,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 253, 253, 252)),
                      ),
                      Text(
                        widget.category,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 253, 253, 252)),
                      ),
                      Text(
                        '${widget.date.day} - ${widget.date.month} - ${widget.date.year}',
                      ),
                      Text(
                          "votre progres: ${widget.progress.toStringAsFixed(0)}%",
                          style: TextStyle(
                              color: widget.progress < 25
                                  ? Color.fromARGB(255, 246, 65, 108)
                                  : widget.progress < 50
                                      ? Color.fromARGB(255, 255, 160, 45)
                                      : widget.progress < 75
                                          ? Color.fromARGB(255, 255, 222, 125)
                                          : Color.fromARGB(
                                              255, 104, 217, 195))),
                    ],
                  ),
                ),
              );
            });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 40),
          child: Slidable(
            endActionPane: ActionPane(motion: StretchMotion(), children: [
              SlidableAction(
                onPressed: widget.delTask,
                icon: Icons.delete,
                backgroundColor: Color.fromARGB(255, 246, 65, 108),
                borderRadius: BorderRadius.circular(15),
              )
            ]),
            child: Container(
              width: 336,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 34, 40, 49),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                widget.taskName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 253, 253, 252)),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                widget.category,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 253, 253, 252)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.date.day} - ${widget.date.month} - ${widget.date.year}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color.fromARGB(255, 188, 196, 207),
                              ),
                            ),
                            Text(
                              '${widget.date.difference(DateTime.now()).inDays}  jours restants',
                              style: TextStyle(
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                          height: 10.0,
                          width: 300.0,
                          child: Slider(
                              value: widget.progress,
                              min: 0,
                              max: 100,
                              onChanged: (value) {
                                setState(() {
                                  widget.onProgressChanged(value);
                                });
                              },
                              inactiveColor: Color.fromARGB(255, 50, 60, 72),
                              activeColor: widget.progress < 25
                                  ? Color.fromARGB(255, 246, 65, 108)
                                  : widget.progress < 50
                                      ? Color.fromARGB(255, 255, 160, 45)
                                      : widget.progress < 75
                                          ? Color.fromARGB(255, 255, 222, 125)
                                          : Color.fromARGB(
                                              255, 104, 217, 195))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
