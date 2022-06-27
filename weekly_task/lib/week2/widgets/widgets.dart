import 'package:flutter/material.dart';
import 'package:weekly_task/week2/widgets/scaffold.dart';

class Widgets extends StatefulWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  _WidgetsState createState() => _WidgetsState();
}

class _WidgetsState extends State<Widgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scafoldex(),
    );
  }
}
