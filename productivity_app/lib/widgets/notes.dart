// import 'dart:js';

import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opendialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future opendialog(context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text("Enter Note "),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter Title "),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: "Enter text here"),
              )
            ],
          ),
          actions: [TextButton(onPressed: () {}, child: Text("Submit"))],
        ));
