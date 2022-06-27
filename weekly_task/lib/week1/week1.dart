import 'package:flutter/material.dart';
import 'package:weekly_task/week1/apiLifeCycle.dart';
import 'package:weekly_task/week1/week1_task/debugging.dart';
import 'package:weekly_task/week1/week1_task/install.dart';
import 'package:weekly_task/week1/week1_task/lifecycle.dart';
import 'package:weekly_task/week1/week1_task/navigator/firstpage.dart';
import 'package:weekly_task/week1/week1_task/whatisflutter.dart';

class Week1 extends StatefulWidget {
  const Week1({Key? key}) : super(key: key);

  @override
  _Week1State createState() => _Week1State();
}

class _Week1State extends State<Week1> {
  List<Week1model> week1task = [
    Week1model(week1title: "What is Flutter", ontapweek1: Whatisflutter()),
    Week1model(week1title: "Install Flutter", ontapweek1: Install()),
    Week1model(
        week1title: "view controller life cycle/activity",
        ontapweek1: LifeCycleExm()),
    Week1model(week1title: "debugging app", ontapweek1: Debugging()),
    Week1model(week1title: "navigation push/pops", ontapweek1: Firstpage()),
    Week1model(week1title: "navigation push/pops", ontapweek1: InitPage1()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WEEK 1",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
          itemCount: week1task.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => week1task[index].ontapweek1),
                  );
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 100,
                    width: 300,
                    child: Center(
                        child: Text(
                      week1task[index].week1title,
                      style: TextStyle(fontSize: 30),
                    )),
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
                        color: Colors.amber,
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )),
    );
  }
}

class Week1model {
  final String week1title;
  final Widget ontapweek1;

  Week1model({required this.ontapweek1, required this.week1title});
}
