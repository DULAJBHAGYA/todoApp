import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/ChooseAction.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Home> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: violet,
        actions: [
          IconButton(
            onPressed: () async {
              bool logoutConfirmed = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Do you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // Return true to indicate logout confirmed
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Return false to indicate cancel
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );

              if (logoutConfirmed == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseAction()),
                );
              }
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              violet,
              blue,
              white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('../assets/images/logo.png'),
                  radius: 40,
                ),
                SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Hello! \nUsername',
                    style: GoogleFonts.openSans(
                      color: white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final color =
                      Color(0xFFEFEFEF).withOpacity((index + 1) / tasks.length);
                  return Dismissible(
                    key: Key(task.name),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text("Do you want to delete the task?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    direction: DismissDirection.endToStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.completed,
                            onChanged: (value) {
                              setState(() {
                                task.completed = value ?? false;
                              });
                            },
                          ),
                          title: Text(task.name),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: violet),
                            onPressed: () {
                              _showEditTaskDialog(context, index, task.name);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add, color: violet),
      ),
    );
  }

   void _showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Task',
            style: GoogleFonts.openSans(
                color: darkblue, fontWeight: FontWeight.w400, fontSize: 17),
          ),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newTask.trim().isNotEmpty) {
                  setState(() {
                    tasks.add(Task(name: newTask, completed: false));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add',
                style: GoogleFonts.openSans(
                  color: darkblue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, int index, String currentTaskName) {
    String editedTask = currentTaskName;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            onChanged: (value) {
              editedTask = value;
            },
            controller: TextEditingController()..text = currentTaskName,
            decoration: InputDecoration(hintText: 'Edit task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (editedTask.trim().isNotEmpty) {
                  setState(() {
                    tasks[index].name = editedTask;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Task {
  String name;
  bool completed;

  Task({required this.name, required this.completed});
}
