import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/datePicker.dart';
import 'package:todoapp/components/timePicker.dart';
import 'package:todoapp/pages/Home.dart';

class Task {
  String title;
  DateTime date;
  TimeOfDay time;

  Task({required this.title, required this.date, required this.time});

  get isChecked => null;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': '${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}',
      'time': '${time.hour}:${time.minute}',
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      date: _parseDate(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
    );
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
  }

  static DateTime _parseDate(String dateString) {
    List<String> parts = dateString.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}

class PopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // Adjust these values according to your needs
    const double cardWidth = 300.0;
    const double cardHeight = 300.0;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: white,
            title: Text(
              'Add Task',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
                      hintText: 'Enter Task',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  DatePickerWidget(
                    onDateSelected: (date) {
                      selectedDate = date;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TimePicker(
                    onTimeSelected: (time) {
                      selectedTime = time;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),

                        ),
                        onPressed: () async {
                          String title = _titleController.text;
                          if (title.isNotEmpty &&
                              selectedDate != null &&
                              selectedTime != null) {
                            Task task = Task(
                              title: title,
                              date: selectedDate!,
                              time: selectedTime!,
                            );
                            try {
                              await saveTask(task);
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            } catch (e) {
                              print('Error saving task: $e');
                              // Handle error saving task
                            }
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: darkblue,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
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
                          style: TextStyle(
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
      body: PopupCard(),
    ),
  ));
}

Future<List<Task>> getTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? tasksJson = prefs.getStringList('tasks');
  if (tasksJson == null) return [];
  return tasksJson
      .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
      .toList();
}

Future<void> saveTask(Task task) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Task> tasks = await getTasks();
  tasks.add(task);
  List<String> tasksJson =
      tasks.map((task) => jsonEncode(task.toJson())).toList();
  prefs.setStringList('tasks', tasksJson);

  print('Task saved: ${task.title}, Date: ${task.date}, Time: ${task.time}');
}
