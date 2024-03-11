import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
              );
              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: Text('Choose date',
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.grey
            ),
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: DatePickerWidget(),
    ),
  ));
}
