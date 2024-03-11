import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/bottomNavigation.dart';
import 'package:todoapp/components/deleteModal.dart';
import 'package:todoapp/components/todoItems.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: violet,
            padding: EdgeInsets.only(top: 30, left: 40),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('path_to_your_image'),
                  radius: 40,
                ),
                SizedBox(width: 20), // Adjust spacing as needed
                Text(
                  'Hi!\nDulaj Bhagya',
                  style: GoogleFonts.openSans(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.2,
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                children: [
                  Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeletePopupCard()), 
                        );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ToDoItems(),
                  ),
                  // Repeat Dismissible for each ToDoItem
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }
}
