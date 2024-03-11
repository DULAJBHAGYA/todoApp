import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/datePicker.dart';
import 'package:todoapp/components/timePicker.dart';
import 'package:todoapp/pages/Home.dart';

class PopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();

    // Adjust these values according to your needs
    const double cardWidth = 300.0;
    const double cardHeight = 300.0;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Add Task',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: violet, // Assuming 'violet' is defined somewhere
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
                      hintText: 'Enter Task',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  DatePickerWidget(),

                  SizedBox(height: 20.0),

                  TimePicker(),
                  
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: violet,
                          minimumSize: Size(100, 50),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          String title = _titleController.text;
                          Navigator.of(context).pop();
                        },
                        child: Text('Add',
                        style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        ),
                      

                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: violet,
                          minimumSize: Size(100, 50),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()), 
                        );
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
      body: PopupCard(),
    ),
  ));
}
