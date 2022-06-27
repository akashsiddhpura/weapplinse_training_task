import 'package:flutter/material.dart';
import 'package:weekly_task/week1/week1_task/navigator/firstpage.dart';
import 'package:weekly_task/week1/week1_task/navigator/secondpage.dart';
import 'package:weekly_task/week1/week1_task/navigator/thirdpage.dart';

class Fourthpage extends StatefulWidget {
  const Fourthpage({Key? key}) : super(key: key);

  @override
  _FourthpageState createState() => _FourthpageState();
}

class _FourthpageState extends State<Fourthpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "4th  page",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "4th page is now on 2nd page stack",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Secondpage()),
                        (route) => false);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "page 2 pushand removeuntill",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
