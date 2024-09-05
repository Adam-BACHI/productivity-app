import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/comps/daySquare.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class MonthSummery extends StatefulWidget {
  const MonthSummery({
    super.key,
  });

  @override
  State<MonthSummery> createState() => _MonthSummeryState();
}

class _MonthSummeryState extends State<MonthSummery> {
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

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 50, right: 50, bottom: 20),
      child: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 300,
          child: AnimationLimiter(
            child: GridView.builder(
                itemCount:
                    DateTime.now().difference(_myBase.get("STARTDATE")).inDays +
                                2 >=
                            49
                        ? DateTime.now()
                                .difference(_myBase.get("STARTDATE"))
                                .inDays +
                            2
                        : 49,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7),
                itemBuilder: (context, i) {
                  return AnimationConfiguration.staggeredGrid(
                    position: i,
                    columnCount: 3,
                    child: ScaleAnimation(
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: DaySquare(
                            date:
                                _myBase.get("STARTDATE").add(Duration(days: i)),
                          )),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
