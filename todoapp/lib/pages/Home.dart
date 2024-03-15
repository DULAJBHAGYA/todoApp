import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/pages/ChooseAction.dart';
import '../services/task.dart';
import '../services/taskServices.dart'; // Import the Task class

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];
  String? username;

  @override
  void initState() {
    super.initState();
    checkTokenValidity();
  }

  Future<void> checkTokenValidity() async {
    final token = await getToken();
    if (token != null) {
      final bool isExpired = isTokenExpired(token);
      if (isExpired) {
        showSessionExpiredDialog();
      } else {
        final username = extractUsernameFromToken(token);
        setState(() {
          this.username = username;
        });
        fetchTasks(username);
      }
    } else {
      // Handle null token case
      navigateToLoginPage();
    }
  }

  bool isTokenExpired(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return true;
    }

    final payload = parts[1];
    String decodedPayload = payload;
    while (decodedPayload.length % 4 != 0) {
      decodedPayload += '=';
    }

    final payloadJson = utf8.decode(base64Url.decode(decodedPayload));
    final payloadMap = json.decode(payloadJson);

    if (payloadMap['exp'] == null) {
      return true;
    }

    final expirationTime =
        DateTime.fromMillisecondsSinceEpoch(payloadMap['exp'] * 1000);
    final currentTime = DateTime.now();

    return expirationTime.isBefore(currentTime);
  }

  Future<void> showSessionExpiredDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Session Expired',
            style: GoogleFonts.openSans(
              color: darkblue,
            ),
          ),
          content: Text(
            'Your session has expired. Please log in again.',
            style: GoogleFonts.openSans(
              color: darkblue,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await logout();
                Navigator.of(context).pop();
                navigateToLoginPage();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChooseAction()),
    );
  }

  String extractUsernameFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return 'Unknown';
    }

    final payload = parts[1];
    String decodedPayload = payload;
    while (decodedPayload.length % 4 != 0) {
      decodedPayload += '=';
    }

    final payloadJson = utf8.decode(base64Url.decode(decodedPayload));
    final payloadMap = json.decode(payloadJson);

    return payloadMap['username'] ?? 'Unknown';
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> fetchTasks(String username) async {
    try {
      final tasksData = await TaskService.instance.getTasks(username);
      setState(() {
        tasks = tasksData.map<Task>((taskJson) => Task.fromJson(taskJson)).toList();
      });
    } catch (e) {
      // Handle errors
      print('Error fetching tasks: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch tasks. Please try again later.'),
      ));
    }
  }

  Future<void> addTask(String taskName) async {
    try {
      await TaskService.instance.createTask(taskName);
      fetchTasks(username!);
    } catch (e) {
      // Handle errors
      print('Error adding task: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add task. Please try again later.'),
      ));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await TaskService.instance.updateTask(task.id, task.name,task.completed as DateTime);
      fetchTasks(username!);
    } catch (e) {
      // Handle errors
      print('Error updating task: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update task. Please try again later.'),
      ));
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await TaskService.instance.deleteTask(task.id);
      fetchTasks(username!);
    } catch (e) {
      // Handle errors
      print('Error deleting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete task. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: violet,
        title: Text(
          'Hello! \n${username ?? 'Username'}',
          style: GoogleFonts.openSans(
            color: white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                        onPressed: () async {
                          Navigator.of(context).pop(true);
                          await logout();
                          navigateToLoginPage();
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );

              if (logoutConfirmed == true) {
                navigateToLoginPage();
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
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
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
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      deleteTask(task);
                    },
                    direction: DismissDirection.endToStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
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
                              updateTask(task);
                            },
                          ),
                          title: Text(task.name),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: violet),
                            onPressed: () {
                              _showEditTaskDialog(context, task);
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
              color: darkblue,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
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
                  addTask(newTask);
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

  void _showEditTaskDialog(BuildContext context, Task task) {
    String editedTask = task.name;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            onChanged: (value) {
              editedTask = value;
            },
            controller: TextEditingController()..text = task.name,
            decoration: InputDecoration(hintText: 'Edit task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (editedTask.trim().isNotEmpty) {
                  task.name = editedTask;
                  updateTask(task);
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
