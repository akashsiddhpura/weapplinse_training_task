import 'package:flutter/material.dart';
import 'package:weekly_task/week4/Map/map_demo.dart';
import 'package:weekly_task/week4/call-sms-email/sms/sendservice.dart';

import 'package:weekly_task/week4/lazy_loading.dart';

class Week4 extends StatefulWidget {
  const Week4({Key? key}) : super(key: key);

  @override
  State<Week4> createState() => _Week4State();
}

class _Week4State extends State<Week4> {
  List<Week4model> week4list = [
    Week4model(week4title: "Lazy Loading", ontapweek4: LazyLoading()),
    Week4model(week4title: "Map intigration", ontapweek4: Mapdemo()),
    Week4model(week4title: "call- sms - email", ontapweek4: SendService()),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 4",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week4list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week4list[index].ontapweek4),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week4list[index].week4title,
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

class Week4model {
  final String week4title;
  final Widget ontapweek4;

  Week4model({required this.week4title, required this.ontapweek4});
}
