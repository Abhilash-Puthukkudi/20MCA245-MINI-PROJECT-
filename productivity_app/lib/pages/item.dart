import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen(
      {Key? key, required this.name, required this.animal, required this.age})
      : super(key: key);

  final String name, animal;
  final int age;

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
    );
  }
}
