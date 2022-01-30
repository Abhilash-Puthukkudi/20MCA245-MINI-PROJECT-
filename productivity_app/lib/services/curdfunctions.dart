import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

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
