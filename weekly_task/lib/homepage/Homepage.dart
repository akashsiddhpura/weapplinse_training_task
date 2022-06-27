import 'package:flutter/material.dart';
import 'package:weekly_task/week1/week1.dart';
import 'package:weekly_task/week11/week11.dart';
import 'package:weekly_task/week2/week2.dart';
import 'package:weekly_task/week3/week3.dart';
import 'package:weekly_task/week4/week4.dart';
import 'package:weekly_task/week5/week5.dart';
import 'package:weekly_task/week6/week6.dart';
import 'package:weekly_task/week7/week7.dart';
import 'package:weekly_task/week8/week8.dart';
import 'package:weekly_task/week9/week9.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Weekmodel> weeks = [
    Weekmodel(title: "week 1", widget: Week1()),
    Weekmodel(title: "week 2", widget: Week2()),
    Weekmodel(title: "week 3", widget: Week3()),
    Weekmodel(title: "week 4", widget: Week4()),
    Weekmodel(title: "week 5", widget: Week5()),
    Weekmodel(title: "week 6", widget: Week6()),
    Weekmodel(title: "week 7", widget: week7()),
    Weekmodel(title: "week 8", widget: week8()),
    Weekmodel(title: "week 9 & 10", widget: week9()),
    Weekmodel(title: "week 11", widget: week11()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'week task',
            style: TextStyle(fontSize: 30),
          )),
          backgroundColor: Colors.black87,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15,left: 15),
          child: ListView.builder(
              itemCount: weeks.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => weeks[index].widget),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Color.fromARGB(255, 47, 128, 237),
                                Color.fromARGB(255, 86, 204, 242),

                              ]),
                          color: Colors.amber,
                          // border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          weeks[index].title,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
        ));
  }
}

class Weekmodel {
  final String title;
  final Widget widget;

  Weekmodel({required this.widget, required this.title});
}
