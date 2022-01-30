import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opendialog(context);
        },
        child: const Icon(Icons.add),
        tooltip: "click to add todo",
      ),
    );
  }
}

Future opendialog(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text("Enter Todo "),
          content: TextField(
            decoration: InputDecoration(hintText: "Enter Task to Do"),
          ),
          actions: [TextButton(onPressed: () {}, child: Text("Submit"))],
        ));