import 'package:flutter/material.dart';
import 'package:productivity_app/comps/ProgressTracker.dart';
import 'package:productivity_app/comps/TaskComp.dart';
import 'package:productivity_app/comps/newTask.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List ToDoList = [
    ["exercie", "health", DateTime.now()],
    ["drink water", "health", DateTime.now()],
    ["revise", "study", DateTime.now()],
  ];

  String _dropValue = "categorie";
  DateTime _date = DateTime.now();

  void _save() {
    setState(() {
      ToDoList.add([_controller.text, _dropValue, _date]);
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
              itemCount: ToDoList.length,
              itemBuilder: (context, index) {
                return TaskComp(
                    taskName: ToDoList[ToDoList.length - 1 - index][0],
                    category: ToDoList[ToDoList.length - 1 - index][1],
                    date: ToDoList[ToDoList.length - 1 - index][2]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10),
            child: GestureDetector(
              onTap: () {},
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
          ProgressTracker()
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
                onPressed: () {},
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
                onPressed: () {},
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
