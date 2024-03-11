import 'package:flutter/material.dart';


void main() {
  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: tdBGColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            welcomeText(),
            welcomeButton(context),
          ],
        ),
      ),
    );
  }

  OutlinedButton welcomeButton(BuildContext context) {
    return OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
            child: Text(
              'Click here to continue',
              style: TextStyle(
                fontSize: 18,
                // color: tdBlue, 
                fontWeight: FontWeight.normal,
              ),
            ),
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(width: 2.0)),
            ),
          );

  }

  Widget welcomeText() {
    return Text(
      "Hello !",
      style: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        // color: tdBlue,
      ),
    );
  }
}
