import 'package:flutter/material.dart';

class DayCounter extends StatefulWidget {
  const DayCounter({Key? key}) : super(key: key);

  @override
  _DayCounterState createState() => _DayCounterState();
}

class _DayCounterState extends State<DayCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("DAY COUNTER"),
    ));
  }
}
