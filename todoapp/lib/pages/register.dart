import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../color.dart';
import 'login.dart';

class User {
  String name;
  String userName;
  String email;
  String password;

  User({
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 void _saveUserData() async {
  if (_formKey.currentState!.validate()) {
    User user = User(
      name: _nameController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('users') ?? [];
      users.add(json.encode(user.toJson())); 
      await prefs.setStringList('users', users);
      print('User data saved successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
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
                'Hello!\nSign up',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
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
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
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
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_confirmPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible = !_confirmPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: violet,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: _saveUserData,
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: violet,
                          ),
                          child: Center(
                            child: Text(
                              'SIGN UP',
                              style: GoogleFonts.openSans(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an Account",
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
                                  MaterialPageRoute(builder: (context) => Login()),
                                );
                              },
                              child: Text(
                                  "Sign in",
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: violet,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

