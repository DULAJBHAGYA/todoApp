import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/Home.dart';
import 'package:todoapp/pages/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false; 
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  blue,
                  violet,
                  lightBlue,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 22),
              child: Text(
                'Hello!\nSign in',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more validation logic for email here
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            labelText: 'E Mail',
                            labelStyle: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: violet,
                              fontSize: 20, // Increase label text size
                            )),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible, // Toggle password visibility
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Password strength validation
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain uppercase letters';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain lowercase letters';
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain numbers';
                          }
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password must contain special characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Toggle password visibility
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                            fontSize: 20, // Increase label text size
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, navigate to Home screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: violet,
                          ),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: GoogleFonts.openSans(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                              "Don't have an Account",
                              style: GoogleFonts.openSans(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: violet,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Register()),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: violet,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
