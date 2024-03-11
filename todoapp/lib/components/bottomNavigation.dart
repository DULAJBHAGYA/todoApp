import 'package:flutter/material.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/modal.dart';

import '../pages/Home.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: violet,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
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
          Positioned(
            bottom: 0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PopupCard()), 
                        );
              },
              child: const Icon(Icons.add,),
              backgroundColor: white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
