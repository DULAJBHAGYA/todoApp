import 'package:flutter/material.dart';
import 'package:todoapp/color.dart'; // Assuming your colors are defined here

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightPurple,
                  blue,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: Text('Hello\nSign in!', style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.check, color: Colors.grey,),
                      label: Text('E Mail', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: violet,
                
                      ),)
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility_off, color: Colors.grey,),
                      label: Text('Password', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: violet,
                
                      ),
                      ),
                    ),
                  )
                ],),
              ),
            ),
          )
        ],
      ),
    );
  }
}
