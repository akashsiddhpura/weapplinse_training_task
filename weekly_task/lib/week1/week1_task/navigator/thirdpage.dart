import 'package:flutter/material.dart';
import 'package:weekly_task/week1/week1_task/navigator/firstpage.dart';
import 'package:weekly_task/week1/week1_task/navigator/secondpage.dart';

class Thirdpage extends StatefulWidget {
  const Thirdpage({Key? key}) : super(key: key);

  @override
  _ThirdpageState createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "3rd page",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("pop",style: TextStyle(fontSize: 30),),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "page 2",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("popUntil",style: TextStyle(fontSize: 30),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "pop until to page 1 ",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
