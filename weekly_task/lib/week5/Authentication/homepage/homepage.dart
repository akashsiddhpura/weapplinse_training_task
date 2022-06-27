import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weekly_task/week5/Authentication/google_fb_login/login.dart';
import 'package:weekly_task/week5/Authentication/model/user_model.dart';

class Auth_Homepage extends StatefulWidget {
  Auth_Homepage({Key? key});

  @override
  State<Auth_Homepage> createState() => _Auth_HomepageState();
}

class _Auth_HomepageState extends State<Auth_Homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedinuser = Usermodel();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Google',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Google",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 50,
              ),
              Text(
                user!.email!,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                user!.displayName.toString(),
                style: TextStyle(fontSize: 20),
              ),
              // Text(
              //   "Welcome Back",
              //   style: TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.blueAccent),
              // ),
              SizedBox(
                height: 15,
              ),
              ActionChip(
                label: Text("Logout"),
                onPressed: () {
                  signOutFromGoogle();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    print(FirebaseAuth.instance.currentUser);
    setState(() {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Check_user()));
  }
}
