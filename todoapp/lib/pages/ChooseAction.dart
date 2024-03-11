import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/login.dart';
import 'package:todoapp/pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChooseAction(),
    );
  }
}

class ChooseAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              '../assets/images/cover.png',
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  );
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: violet,
                  borderRadius: BorderRadius.circular(40.0), 
                ),
                child: Center(
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                  );
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: violet,
                  borderRadius: BorderRadius.circular(40.0), 
                ),
                child: Center(
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
