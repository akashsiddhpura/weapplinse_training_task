import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/firebaseservice.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/resetpwd.dart';
import 'package:weekly_task/week9/Firebase_Auth/login_home/login_home.dart';
import 'package:weekly_task/week9/Firebase_Auth/ragistrartion_page/registration.dart';

class AuthLoginpage extends StatefulWidget {
  const AuthLoginpage({Key? key}) : super(key: key);

  @override
  _AuthLoginpageState createState() => _AuthLoginpageState();
}

class _AuthLoginpageState extends State<AuthLoginpage> {
  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  // //googlesignin
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isloading = false;

  bool isHidden = true;

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAnalytics.instance.logScreenView(screenName: "login page open");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailfield = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a email");
        }
        //reg exp for email validation
        if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]")
            .hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),

        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "email",
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
    );

    //password field
    final passwordfield = TextFormField(
      autofocus: false,
      obscureText: isHidden,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("password is required");
        }
        if (!regex.hasMatch(value)) {
          return ("password must be 6 character");
        }
        return null;
      },
      controller: passwordcontroller,
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffix: InkWell(
          onTap: _togglePasswordView,

          /// This is Magical Function
          child: Icon(
            isHidden
                ?

                /// CHeck Show & Hide.
                Icons.visibility
                : Icons.visibility_off,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "password",
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),
    );

    //button field
    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Colors.black,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailcontroller.text, passwordcontroller.text);
        },
        child: Text("Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 170, right: 35, left: 35,bottom: 110),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    emailfield,
                    SizedBox(
                      height: 25,
                    ),
                    passwordfield,
                    SizedBox(
                      height: 45,
                    ),
                    loginbutton,
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Resetpassword())));
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Image(
                image: AssetImage(
                  "assets/images/bottom-onbording.png",
                ),
                alignment: Alignment.bottomLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }

//login function
  signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      // Future.delayed(Duration(milliseconds: 900), () {
        CircularProgressIndicator(color: Colors.black87);
      // });
      await FirebaseAnalytics.instance
          .logEvent(name: "user_login", parameters: {"user_login": "${email}"});

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = await value.user;
        Fluttertoast.showToast(
            msg: "login successfull " + user!.email.toString());
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Login_homepage()));
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

class Auth_Check extends StatelessWidget {
  const Auth_Check({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? 'login_page'
          : 'home_page',
      navigatorObservers: [],
      routes: {
        'login_page': (context) => Logintab(),
        'home_page': (context) => Login_homepage(),
      },
    );
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: 'LOGIN',
                ),
                Tab(
                  text: 'SIGNUP',
                )
              ]),
        ),
        body: TabBarView(children: [
          AuthLoginpage(),
          Registrationpage(),
        ]),
      ),
    );
  }
}
