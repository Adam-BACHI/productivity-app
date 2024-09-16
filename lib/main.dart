import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/pages/Loading.dart';

void main() async {
  // initialise Hive
  await Hive.initFlutter();

  //open box
  await Hive.openBox("TaskBase");
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'Basic_channel',
            channelName: 'Basic notification',
            channelDescription: 'Notification tests for basic tests')
      ],
      debug: true);
  runApp(const ProdApp());
}

class ProdApp extends StatefulWidget {
  const ProdApp({super.key});

  @override
  State<ProdApp> createState() => _ProdAppState();
}

class _ProdAppState extends State<ProdApp> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Loading(),
      theme: ThemeData(
          primarySwatch: Colors.teal,
          brightness: Brightness.dark,
          fontFamily: "Inter"),
    );
  }
}
