import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week11/Save&Get_File.dart';
import 'package:weekly_task/week11/SliverDemo.dart';
import 'package:weekly_task/week11/state_management/GetX/GetXdemo.dart';

class week11 extends StatefulWidget {
  const week11({Key? key}) : super(key: key);

  @override
  State<week11> createState() => _week11State();
}

class _week11State extends State<week11> {
  List<Week11model> week11list = [
    Week11model(
      week11title: "GetX ",
      ontapweek11: GetXDemo(),
    ),
    Week11model(
      week11title: "Flutter Sliver",
      ontapweek11: SliverPersistentAppBar(),
    ),
    Week11model(
      week11title: "save and get file",
      ontapweek11: FileOperationsScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 11",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week11list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              await FirebaseAnalytics.instance.logScreenView(
                  screenClass: "firebase demo ", screenName: "week 11");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week11list[index].ontapweek11),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week11list[index].week11title,
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

class Week11model {
  final String week11title;
  final Widget ontapweek11;

  Week11model({required this.week11title, required this.ontapweek11});
}
