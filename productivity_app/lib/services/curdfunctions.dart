import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

create(String collname, docName, name, animal, int age) async {
  await FirebaseFirestore.instance
      .collection(collname)
      .doc(docName)
      .set({'name': name, 'animal': animal, 'age': age});
  log("data uploaded");
}

update() async {
  FirebaseFirestore.instance
      .collection('pets')
      .doc('Kitty')
      .update({'age': 20});
  log("updated");
}

delete(String colname, docName) async {
  FirebaseFirestore.instance.collection(colname).doc(docName).delete();
  log("dataDeleted");
}

addTodo(String content, String uid) async {
  var time = DateTime.now();
  await FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('todo')
      .doc(time.toString())
      .set({
    'todo': content,
    'done': false,
    'time': time.toString(),
  });
  log("content is " + content);
  log(time.toString());
}

updatetodo(String uid, String timeparameter, String updatetodo) async {
  FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('todo')
      .doc(timeparameter)
      .update({'todo': updatetodo});
  log("updated");
}

// final FirebaseAuth auth = FirebaseAuth.instance;
// final User? user = auth.currentUser;
// final uid = user!.uid;

todo_Delete(uid, timeparameter) {
  FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('todo')
      .doc(timeparameter)
      .delete();
}

addNote(String content, title, String uid) async {
  var time = DateTime.now();
  await FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('notes')
      .doc(time.toString())
      .set({
    'time': time.toString(),
    'title': title,
    'content': content,
  });
  log("NOTE ADDED : content is " + content);
  // log(time.toString());
}

deleteNote(String uid, timeparameter) async {
  await FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('notes')
      .doc(timeparameter)
      .delete();

  log("note deleted");
  // log(time.toString());
}

updateNote(
    String uid, String timeparameter, String updatetitle, updatecontent) async {
  FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('notes')
      .doc(timeparameter)
      .update({'content': updatecontent, 'title': updatetitle});
  log("updated");
}

adddaycounter(String startdate, enddate, uid, title) async {
  var time = DateTime.now();
  await FirebaseFirestore.instance
      .collection('productivityapp')
      .doc(uid)
      .collection('daycountdown')
      .doc(time.toString())
      .set({
    'time': time.toString(),
    'start': startdate,
    'end': enddate,
    'title': title,
  });
  log("Day counter Added ");
  // log(time.toString());
}
