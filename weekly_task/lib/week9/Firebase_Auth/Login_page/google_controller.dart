import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/firebaseservice.dart';
import 'package:weekly_task/week9/Firebase_Auth/login_home/login_home.dart';

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();

  signOut() {}
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton.icon(
              icon: FaIcon(FontAwesomeIcons.google),
              onPressed: () async {
                setState(
                  () {
                    isLoading = true;
                  },
                );
                FirebaseService service = new FirebaseService();
                try {
                  await service.signInwithGoogle();
                  Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(builder: (context) => const Login_homepage()),
                      (route) => false);
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    showMessage(e.message!);
                  }
                }
                setState(
                  () {
                    isLoading = false;
                  },
                );
              },
              label: Text(
                "google signin",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
              ),
            ),
          )
        : CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
