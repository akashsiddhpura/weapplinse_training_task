
import 'package:flutter/material.dart';
import 'package:weekly_task/week8/Animation/animation_3.dart';

class Animation_2 extends StatefulWidget {
  const Animation_2({Key? key}) : super(key: key);

  @override
  State createState() => Animation_2State();
}

// ignore: camel_case_types
class Animation_2State extends State<Animation_2>
    with TickerProviderStateMixin {
  late AnimationController _iconAnimationcontroller;
  late Animation<double> _iconAnimaton;
  late double _scale;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    _iconAnimationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _iconAnimaton = CurvedAnimation(
        parent: _iconAnimationcontroller, curve: Curves.bounceOut);
    _iconAnimaton.addListener(() {
      this.setState(() {});
    });
    _iconAnimationcontroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _buttonController.value;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/images/nature.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: _iconAnimaton.value * 100,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(60.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0),
                        ),
                        GestureDetector(
                          onTapDown: _tapDown,
                          onTapUp: _tapUp,
                          child: Transform.scale(
                            scale: _scale,
                            child: _animatedButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget  _animatedButton() {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff00ffec),
              Color(0xffbaf6e6),
            ],
          )),
      child: Center(
        child: Text(
          'Press',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
  void _tapDown(TapDownDetails details) {
    _buttonController.forward();
  }
  void _tapUp(TapUpDetails details) {
    _buttonController.reverse();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Animation_3()));
  }

}
