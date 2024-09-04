import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/TaskComp.dart';
import 'package:productivity_app/comps/newCat.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/dataBase/TaskList.dart';
import 'package:productivity_app/dataBase/Categories.dart';

class TaskCat extends StatefulWidget {
  const TaskCat({super.key});

  @override
  State<TaskCat> createState() => _TaskCatState();
}

class _TaskCatState extends State<TaskCat> {
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

  void progressChanged(double value, int ind) {
    setState(() {
      db.ToDoList[ind][3] = value;
    });
  }

  List selectedCat = [];

  String _dropValue = "categorie";
  DateTime _date = DateTime.now();
  final _controller = TextEditingController();
  final _controllerCat = TextEditingController();

  void _save() {
    setState(() {
      db.ToDoList.add([_controller.text, _dropValue, _date, 0.0]);
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

  void _saveCat() {
    setState(() {
      categories.add(_controllerCat.text);
    });

    Navigator.of(context).pop();
    _controllerCat.clear();
    db.UpdateData();
  }

  void _cancelCat() {
    Navigator.of(context).pop();
    _controllerCat.clear();
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
          onDateSelection: (date) {
            setState(() {
              _date = date;
            });
          },
        );
      },
    );
    db.UpdateData();
  }

  void remove(int ind) {
    final msg = SnackBar(
      content: Text(
        'vous devez laisser au moins 3 taches',
      ),
      duration: Duration(seconds: 3),
    );
    if (db.ToDoList.length == 3) {
      ScaffoldMessenger.of(context).showSnackBar(msg);
    } else {
      setState(() {
        db.ToDoList.removeAt(db.ToDoList.length - ind - 1);
      });
    }
    db.UpdateData();
  }

  void createCat() {
    showDialog(
        context: context,
        builder: (context) {
          return NewCat(
              controller: _controllerCat, save: _saveCat, cancel: _cancelCat);
        });
    db.UpdateData();
  }

  @override
  Widget build(BuildContext context) {
    List<int> filteredIndexes = [];

    List filteredTasks = db.ToDoList.where((task) {
      final match = selectedCat.isEmpty || selectedCat.contains(task[1]);
      if (match) {
        filteredIndexes.add(db.ToDoList.indexOf(task));
      }
      return match;
    }).toList();

    double ProgressCount() {
      if (filteredTasks.isNotEmpty) {
        double sum = 0.0;
        double res = 0.0;
        for (var i = 0; i < filteredTasks.length; i++) {
          sum = sum + filteredTasks[i][3];
        }

        res = sum / filteredTasks.length;

        return res;
      } else {
        return 0.0;
      }
    }

    //ProgressCount();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 26, 39),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 75, left: 8),
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 21),
              child: ListView.builder(
                itemCount: categories.length + 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == categories.length) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: createCat,
                        color: const Color.fromARGB(255, 0, 184, 169),
                        child: Icon(Icons.add),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  } else {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                            selectedColor: Color.fromARGB(255, 0, 184, 169),
                            backgroundColor: Color.fromARGB(255, 34, 40, 49),
                            checkmarkColor: Color.fromARGB(255, 252, 252, 253),
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 252, 252, 253),
                                fontFamily: 'Open'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 0, 184, 169),
                                  width: 1.0,
                                )),
                            label: Text(categories[index]),
                            selected: selectedCat.contains(categories[index]),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedCat.add(categories[index]);
                                } else {
                                  selectedCat.remove(categories[index]);
                                }
                              });
                            }));
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
                child: Text(
              'Votre progres est de: ${ProgressCount().toStringAsFixed(0)}%',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Open',
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 252, 252, 253)),
            )),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                String TaskName = filteredTasks[index][0];

                String Category = filteredTasks[index][1];

                DateTime Date = filteredTasks[index][2];

                double Progress = filteredTasks[index][3];

                final mainIndex = filteredIndexes[index];

                return TaskComp(
                  taskName: TaskName,
                  category: Category,
                  date: Date,
                  progress: Progress,
                  onProgressChanged: (pro) {
                    progressChanged(pro, mainIndex);
                  },
                  delTask: (context) => remove(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
