import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/daycounter.dart';
import 'package:productivity_app/widgets/notes.dart';
import 'package:productivity_app/widgets/todo.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentIndex = 0;

  Widget callpage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Todo();
      case 1:
        return Notes();
      case 2:
        return DayCounter();
      default:
        return Todo();
    }
  }

  // final screens=[]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productivity App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // uid = '';
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in_outlined),
                label: 'Todos',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_rounded),
                label: 'Notes',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                label: 'Day Counter',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day_rounded),
                label: 'Day Planner',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.content_copy_rounded),
                label: 'Copy Paste',
                backgroundColor: Colors.blue),
          ]),
      body: callpage(currentIndex),
    );
  }
}
