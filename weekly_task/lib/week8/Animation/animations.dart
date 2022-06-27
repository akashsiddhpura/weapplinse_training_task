import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';


class AnimationsDemo extends StatefulWidget {
  const AnimationsDemo({Key? key}) : super(key: key);

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();

}

double position = 0.0;

class _AnimationsDemoState extends State<AnimationsDemo> {
  @override
  void dispose() {
    // TODO: implement dispose
    position = 0.0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Animation"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton( onPressed: (){
            setState(() {
              position -= 40;
            });
          }, icon: Icon(Icons.rotate_left),)
        ],
      ),
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedPositioned(
            left: position,

            duration: Duration(milliseconds: 600),
            child: Image.asset('assets/images/car.png',
              width: 200.0,
            ),
          // ), AnimatedPositioned(
          //   left: position,
          //   duration: Duration(milliseconds: 600),
          //   child: Image.asset('assets/images/car.png',
          //     width: 200.0,
          //   ),
          // ), AnimatedPositioned(
          //   left: position,
          //   duration: Duration(milliseconds: 600),
          //   child: Image.asset('assets/images/car.png',
          //     width: 200.0,
          //   ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('GO!'),
        onPressed: () {
          print(position);
          if(position > 360){
            setState(() {
              position = 0.0;
            });
          }
          else {
            setState(() {

            position += 40;
          });}
        },
      ),

    );
  }
}
