import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _updatetodoController = TextEditingController();
  String todo = '';
  var uid;
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;

    setState(() {
      uid = user!.uid;
      log(uid);
    });
  }

  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('productivityapp')
              .doc(uid)
              .collection('todo')
              .snapshots(),
          builder: (context, mylistSnapshot) {
            if (mylistSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final listdocs = mylistSnapshot.data!.docs;
              return ListView.builder(
                itemCount: listdocs.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Padding(
                    padding: EdgeInsets.all(14),
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          todo_Delete(uid, listdocs[index]['time']);
                        },
                      ),
                      onTap: () {
                        _updatetodoController.text = listdocs[index]['todo'];
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ItemScreen(
                        //               name: listdocs[index]['name'],
                        //               animal: listdocs[index]['animal'],
                        //               age: listdocs[index]['age'],
                        //             )));
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("update Todo"),
                                  content: Form(
                                      key: _formkey,
                                      child: TextFormField(
                                        key: ValueKey('todo'),
                                        controller: _updatetodoController,
                                        decoration: InputDecoration(
                                            hintText: "Enter Task to Do"),
                                        onSaved: (value) {
                                          setState(() {
                                            todo = value!;
                                          });
                                        },
                                      )),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          todo = _updatetodoController.text;

                                          // here you write the codes to input the data into firestore

                                          updatetodo(uid,
                                              listdocs[index]['time'], todo);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                backgroundColor: Colors.blue,
                                                content: Text("Todo updated ")),
                                          );
                                        },
                                        child: Text("update"))
                                  ],
                                ));
                      },
                      title: Text(
                        listdocs[index]['todo'],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ));
                },
              );
            }
          },
        ),
      ),
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

                            // here you write the codes to input the data into firestore

                            addTodo(todo, uid);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text("Todo Added")),
                            );
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
