import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:weekly_task/week2/imageslider.dart';

class Sliderdemo extends StatefulWidget {
  const Sliderdemo({Key? key}) : super(key: key);

  @override
  _SliderdemoState createState() => _SliderdemoState();
}

double rating = 50;
double rangee = 0;
double range1 = 0;
double range2 = 100;
RangeValues values = RangeValues(0.0, 100.0);

class _SliderdemoState extends State<Sliderdemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("slider demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SfSlider(
              value: rating,
              min: 0,
              max: 100,

              activeColor: Color.fromARGB(255, 49, 255, 245),
              showLabels: true,
              thumbIcon: ImageIcon(
                AssetImage("assets/images/star.png"),
                color: Colors.redAccent,
              ),
              onChanged: (value) => setState(() => rating = value)),
          RaisedButton(
            child: Text("enter"),
            onPressed: () {
              setState(() {
                // print(rating);
                rangee = rating;
              });
            },
          ),
          Text("$rangee"),
          Divider(),
          RangeSlider(
              min: 0.0,
              max: 100.0,
              values: values,
              divisions: 100,
              activeColor: Colors.purple,
              labels: RangeLabels(values.start.round().toString(),
                  values.end.round().toString()),
              onChanged: (value1) {
                setState(() {
                  values = value1;
                });
              }),
          // RaisedButton(
          //   child: Text("enter"),
          //   onPressed: () {
          //     setState(() {
          //       // print(rating);
          //       rangee = rating;
          //     });
          //   },
          // ),
          Text(values.start.round().toString()),
          Text("to"),
          Text(values.end.round().toString()),
          Divider(),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
