import 'package:flutter/material.dart';
import 'package:weekly_task/week2/drawerdemo.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "favorite page",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            color: Colors.redAccent,
            onPressed: () {
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
            },
            child: Text("drawer page"),
          ),
        ),
      ),
    );
  }
}
