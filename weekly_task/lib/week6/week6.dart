
import 'package:flutter/material.dart';
import 'package:weekly_task/week6/fb%20ads/fb_ads.dart';
import 'package:weekly_task/week6/google%20ads/adssssss.dart';
import 'package:weekly_task/week6/google%20ads/nativevideo.dart';
import 'package:weekly_task/week6/sharing.dart';

class Week6 extends StatefulWidget {
  const Week6({Key? key}) : super(key: key);

  @override
  State<Week6> createState() => _Week6State();

}

class _Week6State extends State<Week6> {
  List<Week6model> week5list = [
    Week6model(
      week5title: "Sharing", ontapweek6: Sharing(),
    ),
    Week6model(
      week5title: "Google Ads", ontapweek6: Adsss(),
    ),
    Week6model(
      week5title: "Facebook Ads", ontapweek6: FbAds(),
    ),
    // Week6model(
    //   week5title: "Native video Ad", ontapweek6: NativeVideo(),
    // ),



  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 6",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week5list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week5list[index].ontapweek6),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week5list[index].week5title,
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

class Week6model {
  final String week5title;
  final Widget ontapweek6;

  Week6model({required this.week5title, required this.ontapweek6});
}
