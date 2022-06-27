

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week5/Authentication/model/user_model.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';

class Login_homepage extends StatefulWidget {
  const Login_homepage({Key? key}) : super(key: key);

  @override
  State<Login_homepage> createState() => _Login_homepageState();
}

class _Login_homepageState extends State<Login_homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedinuser = Usermodel();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    FirebaseAnalytics.instance.logScreenView(screenName: "profile page open");

    FirebaseAnalytics.instance.setUserId(id: user!.uid.toString());
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) => this.loggedinuser = Usermodel.fromMap(value.data()));
    setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${user!.email.toString()}"),
            ActionChip(
              label: Text("Logout"),
              onPressed: () async{
                await FirebaseAnalytics.instance.logEvent(name: "user_logout", parameters: {
                  "logout_user" : "${user!.uid}"
                });
                await FirebaseAuth.instance.signOut();
                logOut();
              },
            )
          ],
        ),
      ),
    );
  }
  Future<void> logOut() async {

    await _auth.signOut();


    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Logintab()));
  }
}
