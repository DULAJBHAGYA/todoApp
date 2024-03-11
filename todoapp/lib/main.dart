import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/pages/Welcome.dart';
import 'package:todoapp/pages/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation',
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        // '/menu': (context) => Menu(),
        // '/calender': (context) => CalendarApp(),
      },
    );
  }
}
