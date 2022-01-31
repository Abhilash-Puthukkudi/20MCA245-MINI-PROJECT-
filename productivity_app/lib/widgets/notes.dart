// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/curdfunctions.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _updatetitleController = TextEditingController();
  final _updatecontentController = TextEditingController();

  String title = '', content = '';
  var uid;
  @override
  void initState() {
    // TODO: implement initState
    getuid();
    super.initState();
  }

  getuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;

    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('productivityapp')
              .doc(uid)
              .collection('notes')
              .snapshots(),
          builder: (context, mylistsnapshot) {
            if (mylistsnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final listdocs = mylistsnapshot.data!.docs;
              return ListView.builder(
                  itemCount: listdocs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Dismissible(
                          background: Container(
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                          key: ValueKey<QueryDocumentSnapshot>(listdocs[index]),
                          onDismissed: (DismissDirection direction) {
                            // deleteNote();
                            deleteNote(uid, listdocs[index]['time']);
                            setState(() {});
                          },
                          child: ListTile(
                            onTap: () {
                              _updatecontentController.text =
                                  listdocs[index]['content'];
                              _updatetitleController.text =
                                  listdocs[index]['title'];
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Update Note  "),
                                        content: Form(
                                          key: _formkey,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  key: ValueKey('title'),
                                                  controller:
                                                      _updatetitleController,
                                                  decoration: InputDecoration(
                                                      hintText: "Enter Title "),
                                                ),
                                                TextFormField(
                                                  key: ValueKey('content'),
                                                  controller:
                                                      _updatecontentController,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: 50,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "update your content here",
                                                      labelText:
                                                          "update content of your note",
                                                      border:
                                                          OutlineInputBorder()),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                String updatecontent =
                                                    _updatecontentController
                                                        .text;
                                                String updatetitle =
                                                    _updatetitleController.text;
                                                updateNote(
                                                    uid,
                                                    listdocs[index]['time'],
                                                    updatetitle,
                                                    updatecontent);
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        content: Text(
                                                            'Note updated')));
                                              },
                                              child: Text("Update Note"))
                                        ],
                                      ));
                            },
                            title: Center(
                                child: Text(
                              listdocs[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic),
                            )),
                            subtitle: Center(
                              child: Text(
                                listdocs[index]['content'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Enter Note  "),
                    content: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey('title'),
                              controller: _titleController,
                              decoration:
                                  InputDecoration(hintText: "Enter Title "),
                            ),
                            TextFormField(
                              key: ValueKey('content'),
                              controller: _contentController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 50,
                              decoration: InputDecoration(
                                  hintText: "Enter text here",
                                  labelText: "Type content of your text",
                                  border: OutlineInputBorder()),
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            content = _contentController.text;
                            title = _titleController.text;
                            addNote(content, title, uid);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text('Note Added')));
                          },
                          child: Text("Add Note"))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
