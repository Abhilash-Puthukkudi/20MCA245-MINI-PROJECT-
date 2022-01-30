import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/pages/mylist.dart';
import 'package:productivity_app/services/curdfunctions.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("create"),
                onPressed: () {
                  // create();
                  delete('pets', 'kitty');
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("create"),
                onPressed: () {
                  // create();
                  create("mycollection", "doc2", "human", "abhilash", 10);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("retrival"),
                onPressed: () {
                  // create();
                  // create("material", "doc2", "human", "abhilash", 10);
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (builder) => Mylist()));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Mylist()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
