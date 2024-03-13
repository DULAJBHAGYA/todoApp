import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/Home.dart';

class EditPopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();

    const double cardWidth = 300.0;
    const double cardHeight = 150.0;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Edit Task',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: darkblue, // Assuming 'violet' is defined somewhere
              ),
            ),
            contentPadding: EdgeInsets.all(20.0), // Adjust padding as needed
            content: Container(
              width: cardWidth, // Adjust width as needed
              height: cardHeight, // Adjust height as needed
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimum size
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Edit Task',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String title = _titleController.text;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Add',
                          style: GoogleFonts.openSans(
                              color: darkblue,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.openSans(
                              color: darkblue,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });

    return Container(); // This is a placeholder, you can return any widget here if needed
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Popup Example'),
      ),
      body: EditPopupCard(),
    ),
  ));
}
