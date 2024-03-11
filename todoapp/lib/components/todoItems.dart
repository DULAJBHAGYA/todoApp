import 'package:flutter/material.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/components/editModal.dart';

class ToDoItems extends StatefulWidget {
  const ToDoItems({Key? key}) : super(key: key);

  @override
  _ToDoItemsState createState() => _ToDoItemsState();
}

class _ToDoItemsState extends State<ToDoItems> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(
            255, 220, 192, 232), 
        borderRadius: BorderRadius.circular(20), 
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
          print('Clicked on to do item.');
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: violet,
        ),
        title: Text(
          'Check Mail',
          style: TextStyle(
            fontSize: 16,
            color: black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: violet,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPopupCard()), // Navigate to Home screen
                        );
                },
              ),
            ),

            // Container(
            //   height: 35,
            //   width: 35,
            //   decoration: BoxDecoration(
            //     color: violet,
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: IconButton(
            //     color: Colors.white,
            //     iconSize: 18,
            //     icon: Icon(Icons.delete),
            //     onPressed: () {
            //       print('Clicked on delete icon');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
