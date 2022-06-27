import 'package:flutter/material.dart';
import 'package:weekly_task/week3/API/apicalling.dart';
import 'package:weekly_task/week3/SQLite/page/home_page.dart';

import 'package:weekly_task/week3/gesture.dart';
import 'package:weekly_task/week3/gesture2.dart';
import 'package:weekly_task/week3/imagepicker.dart';

class Week3 extends StatefulWidget {
  const Week3({Key? key}) : super(key: key);

  @override
  State<Week3> createState() => _Week3State();
}

class _Week3State extends State<Week3> {
  List<Week3model> week3list = [
    Week3model(week1title: "Gesture", ontapweek3: Gesturedemo()),
    Week3model(week1title: "Image Picker", ontapweek3: Imagepicker()),
    Week3model(week1title: "SQLite", ontapweek3: SQLHomePage()),
    Week3model(week1title: "API Calling", ontapweek3: ApiCalling()),
    Week3model(week1title: "GestureFullDemo", ontapweek3: GestureFullDemo())
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 3",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week3list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week3list[index].ontapweek3),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week3list[index].week1title,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [
                        0.1,
                        0.5,
                        0.7,
                        0.9
                      ],
                      colors: [
                        Colors.yellow.shade800,
                        Colors.yellow.shade700,
                        Colors.yellow.shade600,
                        Colors.yellow.shade400
                      ]),
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Week3model {
  final String week1title;
  final Widget ontapweek3;

  Week3model({required this.week1title, required this.ontapweek3});
}
