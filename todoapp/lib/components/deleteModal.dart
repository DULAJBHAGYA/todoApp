import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/Home.dart';

class DeletePopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();

    const double cardWidth = 300.0;
    const double cardHeight = 80.0;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Are you sure you want to delete Task?',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w400,
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
                  

                  SizedBox(height: 30,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String title = _titleController.text;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.openSans(
                              color: darkblue,
                              fontSize: 15,
                              ),
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
                          'No',
                          style: GoogleFonts.openSans(
                              color: darkblue,
                              fontSize: 15,
                              ),
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
      body: DeletePopupCard(),
    ),
  ));
}
