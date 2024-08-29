import 'package:flutter/material.dart';
import 'package:productivity_app/comps/ProgressTracker.dart';
import 'package:productivity_app/comps/TaskComp.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/pages/TaskCategories.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  void progressChanged(double value, int ind) {
    setState(() {
      ToDoList[ToDoList.length - ind - 1][3] = value;
    });
  }

  String _dropValue = "categorie";
  DateTime _date = DateTime.now();

  void _save() {
    setState(() {
      ToDoList.add([_controller.text, _dropValue, _date, 0.0]);
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  void _cancel() {
    Navigator.of(context).pop();
    _controller.clear();
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
  }

  void remove(int ind) {
    final msg = SnackBar(
      content: Text(
        'vous devez laisser au moins 3 taches',
      ),
      duration: Duration(seconds: 3),
    );
    if (ToDoList.length == 3) {
      ScaffoldMessenger.of(context).showSnackBar(msg);
    } else {
      setState(() {
        ToDoList.removeAt(ToDoList.length - ind - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 26, 39),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/images/LOGO-nav.png',
                  width: 90,
                ),
                const Icon(
                  Icons.menu,
                  size: 29,
                  color: Color.fromARGB(255, 0, 184, 169),
                ),
              ],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.only(top: 20, left: 40),
            child: Text(
              'Les taches recamment\najoutees',
              style: TextStyle(
                fontFamily: 'Open',
                fontSize: 26,
                color: Color.fromARGB(255, 252, 252, 253),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: ToDoList.length,
              itemBuilder: (context, index) {
                return TaskComp(
                  taskName: ToDoList[ToDoList.length - index - 1][0],
                  category: ToDoList[ToDoList.length - index - 1][1],
                  date: ToDoList[ToDoList.length - index - 1][2],
                  progress: ToDoList[ToDoList.length - index - 1][3],
                  onProgressChanged: (pro) {
                    progressChanged(pro, index);
                  },
                  delTask: (context) => remove(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 50),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TaskCat();
                }));
              },
              child: const Row(
                children: [
                  Text(
                    'voir plus',
                    style: TextStyle(
                      fontFamily: 'Open',
                      fontSize: 13,
                      color: Color.fromARGB(255, 0, 184, 169),
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 184, 169),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ProgressTracker(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 34, 40, 49),
        onPressed: createTask,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 184, 169),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 0, 184, 169),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TaskCat();
                  }));
                },
                icon: Icon(
                  Icons.folder,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.grid_3x3,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 34, 40, 49),
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 34, 40, 49),
                ))
          ],
        ),
      ),
    );
  }
}
