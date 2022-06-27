import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weekly_task/week5/Authentication/AuthController.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  SocialAuthController _auth = Get.put(SocialAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.blue,
              elevation: 5,
              child: FlatButton.icon(
                onPressed: () {
                  _auth.googleAuth();
                },
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                label: Text(
                  "LOGIN WITH GOOGLE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: FlatButton.icon(
                onPressed: () {
                  _auth.facebookAuth();
                },
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
                label: Text(
                  "LOGIN WITH Facebook",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
