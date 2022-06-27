import 'package:flutter/material.dart';

class Whatisflutter extends StatelessWidget {
  const Whatisflutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "what is flutter",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
                  Colors.purple.shade300,
                  Colors.pink.shade200,
                  Colors.pink.shade100,
                  Colors.pink.shade50
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "WHAT IS FLUTTER ",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w900),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase.",
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Flutter Pros",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w900),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Flutter enables you to make instant changes in the app which is a god-sent when it comes to fixing bugs Flutter-based apps are very smooth in their performance which makes for great UX.With a single code base, quality assurance and testing usually takes much less time.Developing in Flutter is very fast and efficient.",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Flutter Cons",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w900),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "The apps made with Flutter tend to be weighty ones.Flutter-based apps are not supported by browsers as of now. This means no web apps.While Flutter is popular, it has not been around long enough to have a huge resource base. Therefore, your team will need to write a lot of stuff from scratch.Dart is not a popular language and if you want to work with Flutter you will have to learn how to use it.",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
