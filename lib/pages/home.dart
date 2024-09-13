import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/ProgressTracker.dart';
import 'package:productivity_app/comps/TaskComp.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBase db = DataBase();
  final _myBase = Hive.box("TaskBase");

  //for the animation
  double width = 0;
  bool myAnimation = false;

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;
      });
    });
  }

  void progressChanged(double value, int ind) {
    setState(() {
      db.ToDoList[db.ToDoList.length - ind - 1][3] = value;
    });
    db.UpdateData();
  }

  void remove(int ind) {
    const msg = SnackBar(
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

  void hide(int ind) {
    const msg = SnackBar(
      content: Text(
        'vous devez laisser au moins 3 taches',
      ),
      duration: Duration(seconds: 3),
    );
    int cpt = 0;
    for (var i = 0; i < db.ToDoList.length; i++) {
      if (db.ToDoList[i][4] == false) {
        cpt++;
      }
    }
    if (cpt <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(msg);
    } else {
      setState(() {
        db.ToDoList[db.ToDoList.length - ind - 1][4] = true;
      });
    }
    db.UpdateData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 26, 39),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, left: 40),
            child: Text(
              'Les taches recamment\najoutees',
              style: TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 252, 252, 253),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: db.ToDoList.length,
              itemBuilder: (context, index) {
                if (db.ToDoList[db.ToDoList.length - index - 1][4] == false) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200 + index * 250),
                    curve: Curves.easeIn,
                    transform: Matrix4.translationValues(
                        myAnimation ? 0 : width, 0, 0),
                    child: TaskComp(
                      taskName: db.ToDoList[db.ToDoList.length - index - 1][0],
                      category: db.ToDoList[db.ToDoList.length - index - 1][1],
                      time: db.ToDoList[db.ToDoList.length - index - 1][2],
                      progress: db.ToDoList[db.ToDoList.length - index - 1][3],
                      onProgressChanged: (pro) {
                        progressChanged(pro, index);
                      },
                      delTask: (context) => remove(index),
                      hideTask: (context) => hide(index),
                      hideOption: true,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60, top: 10),
            child: ProgressTracker(),
          )
        ],
      ),
    );
  }
}
