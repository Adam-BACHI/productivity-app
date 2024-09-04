import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List ToDoList = [];
//reference the data base
  final _myBase = Hive.box("TaskBase");
//create default data

  void DefaultData() {
    ToDoList = [
      ["exercie", "health", DateTime.now(), 0.0],
      ["drink water", "health", DateTime.now(), 0.0],
      ["revise", "study", DateTime.now(), 0.0],
    ];
  }

//add data if it already exists
  void LoadData() {
    ToDoList = _myBase.get("TODOLIST");
  }

//update new data
  void UpdateData() {
    _myBase.put("TODOLIST", ToDoList);
  }
}
