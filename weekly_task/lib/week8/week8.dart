import 'package:flutter/material.dart';
import 'package:weekly_task/week8/Animation/animation_2.dart';
import 'package:weekly_task/week8/Animation/animations.dart';
import 'package:weekly_task/week8/DeviceResolution.dart';
import 'package:weekly_task/week8/ResponsiveUI/responsiveUI.dart';
import 'package:weekly_task/week8/actionSheet/actionsheet.dart';
import 'package:weekly_task/week8/localization/localization.dart';

class week8 extends StatefulWidget {
  const week8({Key? key}) : super(key: key);

  @override
  State<week8> createState() => _week8State();
}

class _week8State extends State<week8> {
  List<Week8model> week8list = [
    Week8model(
      week8title: "Action sheets",
      ontapweek8: ActionSheet(),
    ),
    Week8model(
      week8title: "Localization",
      ontapweek8: LocalizationDemo(),
    ),
    Week8model(
      week8title: "Responsive UI",
      ontapweek8: ResponsiveUI(),
    ),
    Week8model(
      week8title: "managing 1x, 2x, 3x",
      ontapweek8: DeviceResolution(),
    ),
    Week8model(
      week8title: "Animation UI",
      ontapweek8: Animation_2(),
    ),Week8model(
      week8title: "car Animation",
      ontapweek8: AnimationsDemo(),
    ),


  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 8",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
          itemCount: week8list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => week8list[index].ontapweek8),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 100,
                width: 300,
                child: Center(
                  child: Text(
                    week8list[index].week8title,
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

class Week8model {
  final String week8title;
  final Widget ontapweek8;

  Week8model({required this.week8title, required this.ontapweek8});
}
