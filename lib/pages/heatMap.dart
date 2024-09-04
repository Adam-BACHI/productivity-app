import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/TaskComp.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class HeatMap extends StatefulWidget {
  const HeatMap({super.key});

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {
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

  final _controller = TextEditingController();

  void progressChanged(double value, int ind) {
    setState(() {
      db.ToDoList[db.ToDoList.length - ind - 1][3] = value;
    });
    db.UpdateData();
  }

  String _dropValue = "categorie";
  DateTime _date = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 26, 39),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return TaskComp(
            taskName: db.ToDoList[db.ToDoList.length - index - 1][0],
            category: db.ToDoList[db.ToDoList.length - index - 1][1],
            date: db.ToDoList[db.ToDoList.length - index - 1][2],
            progress: db.ToDoList[db.ToDoList.length - index - 1][3],
            onProgressChanged: (pro) {
              progressChanged(pro, index);
            },
            delTask: (context) => remove(index),
          );
        },
      ),
    );
  }
}
