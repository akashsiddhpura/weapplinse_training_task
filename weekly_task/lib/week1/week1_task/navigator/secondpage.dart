import 'package:flutter/material.dart';
import 'package:weekly_task/week1/week1_task/navigator/firstpage.dart';
import 'package:weekly_task/week1/week1_task/navigator/fourthpage.dart';
import 'package:weekly_task/week1/week1_task/navigator/thirdpage.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "2nd page",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("pop",style: TextStyle(fontSize: 30),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                setState(() {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Firstpage()),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "page 1",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("push",style: TextStyle(fontSize: 30),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Thirdpage()),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "page 3",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("pushReplacement",style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fourthpage(),
                      ),
                    );
                    /*MaterialPageRoute(builder: (context) => Secondpage()*/
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "page 4 push-replacemnet",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
