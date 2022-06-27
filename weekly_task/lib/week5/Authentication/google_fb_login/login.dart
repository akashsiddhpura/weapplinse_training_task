import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weekly_task/homepage/Homepage.dart';
import 'package:weekly_task/week5/Authentication/google_fb_login/fbhome.dart';
import 'package:weekly_task/week5/Authentication/homepage/homepage.dart';
import 'package:weekly_task/week5/Authentication/homepage/facebook.dart';
import 'package:weekly_task/week5/week5.dart';
import 'package:http/http.dart' as http;
import 'package:weekly_task/week9/Firebase_Auth/Login_page/firebaseservice.dart';

class Check_user extends StatelessWidget {
  const Check_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'loginpage' : 'homepage',
      navigatorObservers: [],
      routes: {
        'loginpage': (context) => GoogleLofgin(),
        'homepage': (context) => Auth_Homepage(),
      },
    );
  }
}

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;
  //googlesignin
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //facebook
  final FacebookLogin facebookSignIn = FacebookLogin();

  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  bool isloading = false;

  // Future<Resource?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AuthCredential facebookCredential =
  //             FacebookAuthProvider.credential(result.accessToken!.token);
  //         final userCredential =
  //             await _auth.signInWithCredential(facebookCredential);
  //         return Resource(status: Status.Success);
  //       case LoginStatus.cancelled:
  //         return Resource(status: Status.Cancelled);
  //       case LoginStatus.failed:
  //         return Resource(status: Status.Error);
  //       default:
  //         return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw e;
  //   }
  // }
  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //google button
    final googlebutton = SizedBox(
      child: Card(
        elevation: 5,
        color: Colors.blue,
        child: FlatButton.icon(
          height: 45,
          minWidth: MediaQuery.of(context).size.width,
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Check_user()));
            // isloading = true;
            // setState(() {});
            // try {
            //   final GoogleSignInAccount? googleSigninAcc =
            //       await _googleSignIn.signIn();

            //   if (googleSigninAcc != null) {
            //     final GoogleSignInAuthentication authentication =
            //         await googleSigninAcc.authentication;

            //     final AuthCredential authCredential =
            //         GoogleAuthProvider.credential(
            //             idToken: authentication.idToken,
            //             accessToken: authentication.accessToken);

            //     UserCredential result =
            //         await _auth.signInWithCredential(authCredential);
            //     User? user = await result.user;

            //     if (user != null) {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Auth_Homepage()));
            //     }
            //   }
            // } catch (e) {
            //   print(e);
            // }
            // isloading = false;
            // setState(() {});
          },
          label: Text(
            "LOGIN WITH GOOGLE",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );

    //facebook login
    final facebookbutton = SizedBox(
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: FlatButton.icon(
          height: 45,
          minWidth: MediaQuery.of(context).size.width,
          icon: Icon(
            FontAwesomeIcons.facebook,
            color: Colors.blue,
          ),
          onPressed: ()

              //  async

              {
            // await signInWithFacebook();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FaceBookLoginDemo()));
            // isloading = true;
            // setState(() {});
            // try {
            //   //showDialogh();
            //   LoginResult loginResult = await FacebookAuth.instance
            //       .login(permissions: ['public_profile']);

            //   //AccessToken token = loginResult.accessToken!;

            //   final AuthCredential facebookCredential =
            //       FacebookAuthProvider.credential(
            //           loginResult.accessToken!.token);
            //   UserCredential userCredential =
            //       await _auth.signInWithCredential(facebookCredential);

            //   final userdata = await FacebookAuth.i.getUserData();

            //   User? user = await userCredential.user;
            //   if (user != null) {
            //     print(userdata);
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => Auth_Homepage(user: user)));
            //   } else {
            //     print("token null");
            //   }
            // } on FirebaseAuthException catch (e) {
            //   print(e);
            // }
            // isloading = false;
            // setState(() {});
          },
          label: Text(
            "LOGIN WITH Facebook",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(35),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    googlebutton,
                    SizedBox(
                      height: 5,
                    ),
                    facebookbutton
                  ],
                )),
          ),
        ],
      ),
    );
  }

//login function
  signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = await value.user;
        Fluttertoast.showToast(
            msg: "login successfull " + user!.email.toString());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Auth_Homepage()));
      }).catchError(
        (e) {
          Fluttertoast.showToast(msg: e!.message);
        },
      );
    }
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
        });
  }
}

class Logintab extends StatefulWidget {
  const Logintab({Key? key}) : super(key: key);

  @override
  State<Logintab> createState() => _LogintabState();
}

class _LogintabState extends State<Logintab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => Week5()))),
        backgroundColor: Colors.white,
      ),
      body: Loginpage(),
    );
  }
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

class GoogleLofgin extends StatefulWidget {
  const GoogleLofgin({Key? key}) : super(key: key);

  @override
  State<GoogleLofgin> createState() => _GoogleLofginState();
}

//firebase
final _auth = FirebaseAuth.instance;
//googlesignin
final GoogleSignIn _googleSignIn = GoogleSignIn();

class _GoogleLofginState extends State<GoogleLofgin> {
  @override
  void initState() {
    // TODO: implement initState
    print( FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.currentUser == null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    final googlebutton = SizedBox(
      child: Center(
        child: RaisedButton(
          child: Text("Login"),
          onPressed: () async {
            setState(() {
              isloading = true;
            });

            FirebaseService service = new FirebaseService();
            try {

              await service.signInwithGoogle();
              Navigator.push(
                (context),
                MaterialPageRoute(builder: (context) =>  Auth_Homepage()),
              );
            } catch (e) {
              if (e is FirebaseAuthException) {
               print(e.message);
              }
            }

            // setState(() {
            //   isloading = false;
            // });

            // CircularProgressIndicator();
            // isloading = true;
            // setState(() {});
            // try {
            //   final GoogleSignInAccount? googleSigninAcc =
            //       await _googleSignIn.signIn();
            //
            //   if (googleSigninAcc != null) {
            //     final GoogleSignInAuthentication authentication =
            //         await googleSigninAcc.authentication;
            //
            //     final AuthCredential authCredential =
            //         GoogleAuthProvider.credential(
            //             idToken: authentication.idToken,
            //             accessToken: authentication.accessToken);
            //
            //     UserCredential result =
            //         await _auth.signInWithCredential(authCredential);
            //     User? user = await result.user;
            //
            //     if (user != null) {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Auth_Homepage()));
            //     }
            //   }
            // } catch (e) {
            //   print(e);
            // }
            // isloading = false;
            // setState(() {});
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Google",
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [googlebutton],
      ),
    );
  }
}
