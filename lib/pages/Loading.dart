import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/dataBase/TaskList.dart';
import 'package:productivity_app/pages/root.dart';
import 'package:productivity_app/pages/welcome.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  DataBase db = DataBase();
  final _myBase = Hive.box("TaskBase");
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 20), () {
      if (_myBase.get("TODOLIST") == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const Welcome(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Root(),
        ));
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 26, 39),
        ),
        child: Stack(children: [
          Image.asset('lib/images/LOGO.png'),
        ]),
      ),
    ));
  }
}
