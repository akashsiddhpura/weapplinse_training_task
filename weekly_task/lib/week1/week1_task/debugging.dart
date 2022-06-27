import 'package:flutter/material.dart';

class Debugging extends StatelessWidget {
  const Debugging({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Debugging example",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
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
              "Debugging Flutter apps:",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "1.  DevTool a suite of performance and profiling tools that are run in a browser. ",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "2.  Android Studio / IntelliJ and VS Code support inbuilt source-level debugger with the ability to set the breakpoints, step through the code and examine the values.",
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "3.  Logging view, a widget inspector working in DevTools, and also indirectly from the Android Studio & IntelliJ.The inspector allows to you for examining a visual representation of the widget trees, inspect individual widgets and their property values, enable the performance overlay, and more.",
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
