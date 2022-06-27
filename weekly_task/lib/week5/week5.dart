import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week4/Map/map_demo.dart';
import 'package:weekly_task/week4/call-sms-email/sms/sendservice.dart';
import 'package:weekly_task/week4/lazy_loading.dart';
import 'package:weekly_task/week5/Authentication/HomeScreen.dart';
import 'package:weekly_task/week5/Authentication/google_fb_login/login.dart';
import 'package:weekly_task/week5/Authentication/loginScrenn.dart';
import 'package:weekly_task/week5/audio%20player/audio_player.dart';
import 'package:weekly_task/week5/audio%20player/recording_sound.dart';
import 'package:weekly_task/week5/video%20player/video_page.dart';
import 'package:weekly_task/week5/video%20player/video_player.dart';

class Week5 extends StatefulWidget {
  const Week5({Key? key}) : super(key: key);

  @override
  State<Week5> createState() => _Week5State();
}

class _Week5State extends State<Week5> {
  List<Week5model> week5list = [
    Week5model(
      week5title: "Audio Player",
      ontapweek5: Audio_player(),
    ),
    Week5model(
      week5title: "video Player",
      ontapweek5: VideoPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "WEEK 5",
            style: TextStyle(fontSize: 28),
          ),
          backgroundColor: Colors.black87,
        ),
        body: Column(
          children: [
            Container(
              height: 280,
              child: ListView.builder(
                itemCount: week5list.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => week5list[index].ontapweek5),
                    );
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 100,
                      width: 300,
                      child: Center(
                        child: Text(
                          week5list[index].week5title,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
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
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FirebaseAuth.instance.currentUser == null
                              ? SocialLoginScreen()
                              : SocialHomePage()),
                );
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 100,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Google / Facebook Sign Up",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
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
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Week5model {
  final String week5title;
  final Widget ontapweek5;

  Week5model({required this.week5title, required this.ontapweek5});
}
