import 'package:flutter/material.dart';


class GestureFullDemo extends StatefulWidget {
  const GestureFullDemo({Key? key}) : super(key: key);

  @override
  State<GestureFullDemo> createState() => _GestureFullDemoState();
}

Color conColor = Colors.red;

class _GestureFullDemoState extends State<GestureFullDemo> {
  double heightS = 200.0;
  double widthS = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Gesture"),
        backgroundColor: Colors.black87,
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            conColor = Colors.teal;
          });
        },
        onLongPress: (){
          setState(() {
            conColor = Colors.yellow;
          });
        },
        onVerticalDragStart: (detail){
          setState(() {
            heightS = heightS + 1;
          });
        },
        onVerticalDragUpdate: (detail){
          setState(() {
            heightS = heightS + 1;
          });
        },
        onHorizontalDragUpdate: (detail){
          setState(() {
            widthS = widthS + 1;

          });
        },
        // onPanUpdate: (detail){
        //   setState(() {
        //     heightS = heightS + 1;
        //   });
        // },

        child: Container(
          height: heightS,
          width: widthS,
          color: conColor,
        ),
      ),
    );
  }
}
