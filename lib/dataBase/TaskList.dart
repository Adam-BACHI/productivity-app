import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List ToDoList = [];
  List<String> categories = [];
//reference the data base
  final _myBase = Hive.box("TaskBase");
//create default data

  void DefaultData() {
    ToDoList = [
      [
        "exercie",
        "health",
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
        0.0,
        false,
        DateTime.now()
      ],
      [
        "drink water",
        "health",
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
        0.0,
        false,
        DateTime.now()
      ],
      [
        "revise",
        "study",
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
        0.0,
        false,
        DateTime.now()
      ],
    ];
    categories = [
      'categorie',
      'study',
      'health',
    ];

    _myBase.put("STARTDATE", DateTime.now());

    _myBase.put("TODOLIST", ToDoList);
    _myBase.put("CATEGORIES", categories);
  }

//add data if it already exists
  void LoadData() {
    ToDoList = _myBase.get("TODOLIST");
    categories = _myBase.get("CATEGORIES");
  }

//update new data
  void UpdateData() {
    _myBase.put("TODOLIST", ToDoList);
    _myBase.put("CATEGORIES", categories);
  }
}
