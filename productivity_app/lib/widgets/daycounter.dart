import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/curdfunctions.dart';

class DayCounter extends StatefulWidget {
  const DayCounter({Key? key}) : super(key: key);

  @override
  _DayCounterState createState() => _DayCounterState();
}

class _DayCounterState extends State<DayCounter> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController startdatec = TextEditingController();
  TextEditingController enddatec = TextEditingController();
  DateTime currentdate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentdate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentdate)
      setState(() {
        currentdate = pickedDate;
      });
  }

  var uid;
  @override
  void initState() {
    // TODO: implement initState
    getuid();
    super.initState();
  }

  final _titleController = TextEditingController();

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
              .collection('daycountdown')
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
                        // todo_Delete(uid, listdocs[index]['time']);
                        setState(() {});
                      },
                      child: ListTile(
                        onTap: () {
                          // _updatetodoController.text = listdocs[index]['todo'];
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ItemScreen(
                          //               name: listdocs[index]['name'],
                          //               animal: listdocs[index]['animal'],
                          //               age: listdocs[index]['age'],
                          //             )));
                          // showDialog(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //           title: Text("update Todo"),
                          //           content: Form(
                          //               key: _formkey,
                          //               child: TextFormField(
                          //                 key: ValueKey('todo'),
                          //                 controller: _updatetodoController,
                          //                 decoration: InputDecoration(
                          //                     hintText: "Enter Task to Do"),
                          //                 onSaved: (value) {
                          //                   setState(() {
                          //                     todo = value!;
                          //                   });
                          //                 },
                          //               )),
                          //           actions: [
                          //             TextButton(
                          //                 onPressed: () {
                          //                   todo = _updatetodoController.text;

                          //                   // here you write the codes to input the data into firestore

                          //                   updatetodo(uid,
                          //                       listdocs[index]['time'], todo);
                          //                   Navigator.of(context).pop();
                          //                   ScaffoldMessenger.of(context)
                          //                       .showSnackBar(
                          //                     SnackBar(
                          //                         backgroundColor: Colors.blue,
                          //                         content:
                          //                             Text("Todo updated ")),
                          //                   );
                          //                 },
                          //                 child: Text("update"))
                          //           ],
                          //         ));
                        },
                        title: Text(
                          counting(listdocs[index]['start'],
                                  listdocs[index]['end'])
                              .toString(),
                          style: TextStyle(fontSize: 40),
                        ),
                        subtitle: Text(listdocs[index]['title']),
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
                    title: Text("Add Daycountdown  "),
                    content: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {
                                _selectDate(context);

                                setState(() {
                                  startdatec.text = currentdate
                                      .toLocal()
                                      .toString()
                                      .split(" ")[0];
                                });
                              },
                              controller: startdatec,
                              key: ValueKey('startdate'),
                              // controller: _startdateController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "select start date "),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              onTap: () {
                                _selectDate(context);
                                setState(() {
                                  enddatec.text = currentdate
                                      .toLocal()
                                      .toString()
                                      .split(" ")[0];
                                });
                              },
                              controller: enddatec,
                              key: ValueKey('enddate'),
                              // controller: _contentController,
                              keyboardType: TextInputType.datetime,

                              decoration: InputDecoration(
                                  hintText: "select end date",
                                  // labelText: "Type content of your text",
                                  border: OutlineInputBorder()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextFormField(
                        key: ValueKey('title'),
                        controller: _titleController,
                        decoration: InputDecoration(hintText: "Enter Title "),
                      ),
                      TextButton(
                          onPressed: () {
                            var title = _titleController.text;
                            var startdate = startdatec.text;
                            var enddate = enddatec.text;
                            adddaycounter(startdate, enddate, uid, title);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text('day counter Added')));
                          },
                          child: Text("Add daycounter"))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

String counting(startdate, enddate) {
  DateTime stdate = DateTime.parse(startdate);
  DateTime eddate = DateTime.parse(enddate);
  final difference = stdate.difference(eddate).inDays;

  return difference.toString();
}
