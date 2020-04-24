import 'package:Academia/services/locator.dart';
import 'package:Academia/views/Gerente.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante',
      home: Gerente(),
      theme: ThemeData(
          primaryColor: Colors.blue[700],
          accentColor: Colors.cyan[200],
          fontFamily: 'Raleway',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            subtitle1: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
            subtitle2: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          )),
    );
  }
}
