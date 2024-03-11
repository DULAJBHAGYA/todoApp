import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/bottomNavigation.dart';
import 'package:todoapp/components/todoItems.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: violet,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Text(
                'Hi!\nDulaj Bhagya',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 120,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'All to dos', 
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ToDoItems(),
                    BottomNav()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
