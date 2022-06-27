import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week9/Custom_synamic.dart';
import 'package:weekly_task/week9/FireStore_database/Add_TODO.dart';
import 'package:weekly_task/week9/FireStore_database/View_TODO.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';
import 'package:weekly_task/week9/Notifications/LocalNotification.dart';
import 'package:weekly_task/week9/Notifications/PushNotification.dart';
import 'package:weekly_task/week9/RealTime_database/realtime_emp_ui.dart';
import 'package:weekly_task/week9/crashlytics.dart';
import 'package:weekly_task/week9/dynamic_link.dart';

class week9 extends StatefulWidget {
  const week9({Key? key}) : super(key: key);

  @override
  State<week9> createState() => _week9State();
}

class _week9State extends State<week9> {
  List<Week9model> week9list = [
    Week9model(
      week9title: "Firebase Authentication",
      ontapweek9: Auth_Check(),
    ),
    Week9model(
      week9title: "RealTime Database",
      ontapweek9: RealtimeDatabaseUI(),
    ),
    Week9model(
      week9title: "FireStore Database",
      ontapweek9: View_TODO(),
    ),
    Week9model(
      week9title: "Local Notification",
      ontapweek9: LocalNotification(),
    ),
    // Week9model(
    //   week9title: "Push Notification",
    //   ontapweek9: PushNotification(),
    // ),
    Week9model(
      week9title: "Crashlytics",
      ontapweek9: Firebase_Crashlytics(),
    ),
    Week9model(
      week9title: "Dynamic Link",
      ontapweek9: Dynamic_Link(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 9",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week9list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              await FirebaseAnalytics.instance.logScreenView(
                  screenClass: "firebase demo ", screenName: "week 9");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week9list[index].ontapweek9),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week9list[index].week9title,
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

class Week9model {
  final String week9title;
  final Widget ontapweek9;

  Week9model({required this.week9title, required this.ontapweek9});
}
