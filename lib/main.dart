import 'package:flutter/material.dart';
import 'package:productivity_app/pages/Loading.dart';
import 'package:productivity_app/pages/welcome.dart';

void main() {
  runApp(const ProdApp());
}

class ProdApp extends StatelessWidget {
  const ProdApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
      theme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.dark),
      routes: {
        '/welcomepage': (context) => const Welcome(),
      },
    );
  }
}
