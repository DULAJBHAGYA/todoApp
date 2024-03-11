import 'package:flutter/material.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/modal.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PopupCard()),
                  );
        },
        child: const Icon(
          Icons.add,
          color: white,
          size: 40,
        ),
        shape: CircleBorder(),
        backgroundColor: violet,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: violet,
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 20),
              icon: const Icon(
                Icons.home,
                color: white,
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: const Icon(
                Icons.account_circle,
                color: white,
                size: 40,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
