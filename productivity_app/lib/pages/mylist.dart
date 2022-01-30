import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/pages/item.dart';

class Mylist extends StatefulWidget {
  const Mylist({Key? key}) : super(key: key);

  @override
  _MylistState createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My list"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('mycollection').snapshots(),
          builder: (context, mylistSnapshot) {
            if (mylistSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              final listdocs = mylistSnapshot.data!.docs;
              return ListView.builder(
                itemCount: listdocs.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemScreen(
                                    name: listdocs[index]['name'],
                                    animal: listdocs[index]['animal'],
                                    age: listdocs[index]['age'],
                                  )));
                    },
                    title: Text(listdocs[index]['name']),
                    subtitle: Text(
                      listdocs[index]['animal'],
                    ),
                  ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
