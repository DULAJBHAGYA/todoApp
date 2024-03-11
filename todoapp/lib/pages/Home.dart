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
          
          const BottomNav(),
        ],
      ),
    );
  }
}
