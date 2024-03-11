import 'package:flutter/material.dart';
import 'package:todoapp/color.dart'; // Assuming your colors are defined here

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(top: 40.0, left: 22),
              child: Text(
                'Hello!\nSign up',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
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
                          label: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: violet,
                            ),
                          )),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        label: Text(
                          'E Mail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        label: Text(
                          'User Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 28,
                    ),
                    
                    SizedBox(height: 70),
                    Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: violet,
                        ),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an Account",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: violet,
                              ),
                            ),
                            Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: violet,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
