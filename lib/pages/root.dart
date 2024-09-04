import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/newTask.dart';
import 'package:productivity_app/dataBase/TaskList.dart';
import 'package:productivity_app/pages/TaskCategories.dart';
import 'package:productivity_app/pages/heatMap.dart';
import 'package:productivity_app/pages/home.dart';
import 'package:productivity_app/pages/weekBilan.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _WelcomeState();
}

class _WelcomeState extends State<Root> {
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

  PageController _Pagecontroller = PageController();
  final _controller = TextEditingController();
  int _selectedIndex = 0;

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

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    db.UpdateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 18, 26, 39),
        body: Stack(
          children: [
            PageView(
              controller: _Pagecontroller,
              onPageChanged: onPageChanged,
              children: [
                // DIFFERENT PAGES
                HomePage(),
                TaskCat(),
                Week(),
                HeatMap()
              ],
            ),

            //LOGO IMAGE
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('lib/images/LOGO-nav.png'),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 34, 40, 49),
            onPressed: createTask,
            child: Icon(
              Icons.add,
              color: Color.fromARGB(255, 0, 184, 169),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: GNav(
            gap: 8,
            color: Color.fromARGB(255, 252, 252, 253),
            activeColor: Color.fromARGB(255, 0, 184, 169),
            tabBackgroundColor: Color.fromARGB(255, 34, 40, 49),
            padding: EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                _Pagecontroller.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'principale',
              ),
              GButton(
                icon: Icons.folder,
                text: 'toutes les taches',
              ),
              GButton(
                icon: Icons.date_range_sharp,
                text: 'Bilan de semaine',
              ),
              GButton(
                icon: Icons.grid_view_rounded,
                text: 'Heatmap',
              ),
            ],
          ),
        ));
  }
}
