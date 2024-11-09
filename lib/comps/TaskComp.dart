import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskComp extends StatefulWidget {
  final String taskName;
  final String category;
  final String time;
  final ValueChanged onProgressChanged;
  final double progress;
  final Function(BuildContext)? delTask;
  final Function(BuildContext)? hideTask;
  final bool hideOption;

  const TaskComp({
    super.key,
    required this.taskName,
    required this.category,
    required this.time,
    required this.onProgressChanged,
    required this.progress,
    required this.delTask,
    required this.hideTask,
    required this.hideOption,
  });

  @override
  State<TaskComp> createState() => _TaskCompState();
}

class _TaskCompState extends State<TaskComp> {
  @override
  Widget build(BuildContext context) {
    if (widget.hideOption) {
      return GestureDetector(
        onDoubleTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 18, 26, 39),
                  content: SizedBox(
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
                          widget.time,
                        ),
                        Text(
                            "your progress: ${widget.progress.toStringAsFixed(0)}%",
                            style: TextStyle(
                                color: widget.progress < 25
                                    ? const Color.fromARGB(255, 246, 65, 108)
                                    : widget.progress < 50
                                        ? const Color.fromARGB(
                                            255, 255, 160, 45)
                                        : widget.progress < 75
                                            ? const Color.fromARGB(
                                                255, 255, 222, 125)
                                            : const Color.fromARGB(
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
              endActionPane:
                  ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                  onPressed: widget.hideTask,
                  icon: Icons.remove_red_eye_outlined,
                  backgroundColor: const Color.fromARGB(255, 128, 128, 128),
                  borderRadius: BorderRadius.circular(15),
                ),
                SlidableAction(
                  onPressed: widget.delTask,
                  icon: Icons.delete,
                  backgroundColor: const Color.fromARGB(255, 246, 65, 108),
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
                              SizedBox(
                                width: 200,
                                child: Text(
                                  widget.taskName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 253, 253, 252)),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  widget.category,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color.fromARGB(255, 253, 253, 252)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.time,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
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
                        padding: const EdgeInsets.only(top: 10),
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
                                inactiveColor:
                                    const Color.fromARGB(255, 50, 60, 72),
                                activeColor: widget.progress < 25
                                    ? const Color.fromARGB(255, 246, 65, 108)
                                    : widget.progress < 50
                                        ? const Color.fromARGB(
                                            255, 255, 160, 45)
                                        : widget.progress < 75
                                            ? const Color.fromARGB(
                                                255, 255, 222, 125)
                                            : const Color.fromARGB(
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
    } else {
      return GestureDetector(
        onDoubleTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 18, 26, 39),
                  content: SizedBox(
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
                          widget.time,
                        ),
                        Text(
                            "your progress: ${widget.progress.toStringAsFixed(0)}%",
                            style: TextStyle(
                                color: widget.progress < 25
                                    ? const Color.fromARGB(255, 246, 65, 108)
                                    : widget.progress < 50
                                        ? const Color.fromARGB(
                                            255, 255, 160, 45)
                                        : widget.progress < 75
                                            ? const Color.fromARGB(
                                                255, 255, 222, 125)
                                            : const Color.fromARGB(
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
              endActionPane:
                  ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                  onPressed: widget.delTask,
                  icon: Icons.delete,
                  backgroundColor: const Color.fromARGB(255, 246, 65, 108),
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
                              SizedBox(
                                width: 200,
                                child: Text(
                                  widget.taskName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 253, 253, 252)),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  widget.category,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color.fromARGB(255, 253, 253, 252)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.time,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
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
                        padding: const EdgeInsets.only(top: 10),
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
                                inactiveColor:
                                    const Color.fromARGB(255, 50, 60, 72),
                                activeColor: widget.progress < 25
                                    ? const Color.fromARGB(255, 246, 65, 108)
                                    : widget.progress < 50
                                        ? const Color.fromARGB(
                                            255, 255, 160, 45)
                                        : widget.progress < 75
                                            ? const Color.fromARGB(
                                                255, 255, 222, 125)
                                            : const Color.fromARGB(
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
}
