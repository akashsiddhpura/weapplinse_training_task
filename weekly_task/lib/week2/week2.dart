import 'package:flutter/material.dart';
import 'package:weekly_task/week2/customcontrol.dart';
import 'package:weekly_task/week2/customdrawer.dart';
import 'package:weekly_task/week2/customnav.dart';
import 'package:weekly_task/week2/demoslider.dart';
import 'package:weekly_task/week2/drawerdemo.dart';
import 'package:weekly_task/week2/imageslider.dart';
import 'package:weekly_task/week2/layoutdemo.dart';
import 'package:weekly_task/week2/passingdata/page1.dart';
import 'package:weekly_task/week2/tabbar.dart';
import 'package:weekly_task/week2/customtabbar.dart';
import 'package:weekly_task/week2/widgets/formvalidation.dart';
import 'package:weekly_task/week2/widgets/widgets.dart';

class Week2 extends StatefulWidget {
  const Week2({Key? key}) : super(key: key);

  @override
  _Week2State createState() => _Week2State();
}

class _Week2State extends State<Week2> {
  List<Week2model> week1task = [
    Week2model(week2title: "Tab bar demo", ontapweek2: Tabbar()),
    Week2model(week2title: "Drawer demo", ontapweek2: Drawerdemo()),
    Week2model(week2title: "Slider ", ontapweek2: Sliderdemo()),
    Week2model(week2title: "image slider", ontapweek2: Sliderimage()),
    Week2model(
        week2title: "Data passing",
        ontapweek2: Page_1(
          page2email: '',
          page2name: '',
        )),
    Week2model(week2title: "Widgets", ontapweek2: Widgets()),
    Week2model(week2title: "Layout demo", ontapweek2: LayoutMainPage()),
    Week2model(week2title: "Custom control", ontapweek2: Customcontrols()),
    Week2model(week2title: "Custom NavBar", ontapweek2: Customnav()),
    Week2model(week2title: "Custom TabBar", ontapweek2: CustomSwitchState()),
    Week2model(week2title: "Custom drawer", ontapweek2: CustomDrawer()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WEEK 2",
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
                        builder: (context) => week1task[index].ontapweek2),
                  );
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 100,
                    width: 300,
                    child: Center(
                        child: Text(
                      week1task[index].week2title,
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

class Week2model {
  final String week2title;
  final Widget ontapweek2;

  Week2model({required this.ontapweek2, required this.week2title});
}
