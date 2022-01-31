import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/curdfunctions.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _formkey = GlobalKey<FormState>();
  final _todoController = TextEditingController();
  String todo = '';
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Enter Todo "),
                    content: Form(
                        key: _formkey,
                        child: TextFormField(
                          key: ValueKey('todo'),
                          controller: _todoController,
                          decoration:
                              InputDecoration(hintText: "Enter Task to Do"),
                          onSaved: (value) {
                            setState(() {
                              todo = value!;
                            });
                          },
                        )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            todo = _todoController.text;
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final User? user = auth.currentUser;
                            final uid = user!.uid;
                            // here you write the codes to input the data into firestore

                            addTodo(todo, uid);
                          },
                          child: Text("Submit"))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
        tooltip: "click to add todo",
      ),
    );
  }
}
