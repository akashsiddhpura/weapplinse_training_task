import 'package:flutter/material.dart';
import 'package:weekly_task/week7/InAppPurchase/in_app_purchase.dart';
import 'package:weekly_task/week7/custom%20camera/camera_screen.dart';
import 'package:weekly_task/week7/defaultCamera.dart';
import 'package:weekly_task/week7/defaultVideocamera.dart';
import 'package:weekly_task/week7/pull-to-refresh/pull_to_refresh.dart';

class week7 extends StatefulWidget {
  const week7({Key? key}) : super(key: key);

  @override
  State<week7> createState() => _week7State();
}

class _week7State extends State<week7> {
  List<Week7model> week7list = [

    Week7model(
      week7title: "Pull to Refresh",
      ontapweek7: PullToRefresh(),
    ),
    Week7model(
      week7title: "In app purchase",
      ontapweek7: InApp(),
    ),
    Week7model(
      week7title: "Default camera",
      ontapweek7: DefaultCamera(),
    ),
    Week7model(
      week7title: "Default video camera",
      ontapweek7: CamerasDemo(),
    ),
    // Week7model(
    //   week7title: "In app purchase",
    //   ontapweek7: CameraScreen(),
    // ),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 7",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week7list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week7list[index].ontapweek7),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week7list[index].week7title,
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

class Week7model {
  final String week7title;
  final Widget ontapweek7;

  Week7model({required this.week7title, required this.ontapweek7});
}
