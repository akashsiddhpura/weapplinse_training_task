import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weekly_task/week5/Authentication/model/user_model.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';
import 'package:weekly_task/week9/Firebase_Auth/login_home/login_home.dart';

class Registrationpage extends StatefulWidget {
  const Registrationpage({Key? key}) : super(key: key);

  @override
  _RegistrationpageState createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  final _auth = FirebaseAuth.instance;

  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final firstnamecontroller = TextEditingController();
  final secondnamecontroller = TextEditingController();
  final emaileditingcontroller = TextEditingController();
  final passwordeditingcontroller = TextEditingController();
  final confirmpasswordeditingcontroller = TextEditingController();

  bool isHidden1 = true;
  bool isHidden2 = true;

  void _togglePasswordView() {
    setState(() {
      isHidden1 = !isHidden1;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      isHidden2 = !isHidden2;
    });
  }

  @override
  void initState() {
    FirebaseAnalytics.instance
        .logScreenView(screenName: "Registration page open");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstnamefield = TextFormField(
      autofocus: false,
      controller: firstnamecontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Firstname cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Firstname must be 3 character");
        }
        return null;
      },
      onSaved: (value) {
        firstnamecontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
      ),
    );

    //second name field
    final secondnamefield = TextFormField(
      autofocus: false,
      controller: secondnamecontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Firstname cannot be empty");
        }

        return null;
      },
      onSaved: (value) {
        secondnamecontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
      ),
    );

    //email field
    final emaileditingfield = TextFormField(
      autofocus: false,
      controller: emaileditingcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a email");
        }
        //reg exp for email validation
        if (!RegExp(r"^[a-z0-9+_.-]+@[a-z0-9.-]+\.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emaileditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "email",
      ),
    );

    //password field
    final passwordeditingfield = TextFormField(
      autofocus: false,
      obscureText: isHidden1,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("paasword cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("password must be 6 character");
        }
        return null;
      },
      controller: passwordeditingcontroller,
      onSaved: (value) {
        passwordeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffix: InkWell(
          onTap: _togglePasswordView,

          /// This is Magical Function
          child: Icon(
            isHidden1
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
      ),
    );

    // confirm password field
    final confirpasswordfield = TextFormField(
      autofocus: false,
      obscureText: isHidden2,
      controller: confirmpasswordeditingcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return ("confirm password is required");
        } else if (confirmpasswordeditingcontroller.text !=
            passwordeditingcontroller.text) {
          return ("password don't match");
        }

        return null;
      },
      onSaved: (value) {
        confirmpasswordeditingcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffix: InkWell(
          onTap: _togglePasswordView2,

          /// This is Magical Function
          child: Icon(
            isHidden2 ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: " Confirm password",
      ),
    );

    //sign upbutton field
    final signupbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Colors.black,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Center(child: CircularProgressIndicator());
          FirebaseAnalytics.instance.logEvent(name: "register", parameters: {
            'Value': DateTime.now().microsecondsSinceEpoch.toString()
          });
          signUp(emaileditingcontroller.text, passwordeditingcontroller.text);
        },
        child: Text("Sign up",
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
              padding: EdgeInsets.fromLTRB(35, 35, 35, 122),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      firstnamefield,
                      SizedBox(
                        height: 20,
                      ),
                      secondnamefield,
                      SizedBox(
                        height: 20,
                      ),
                      emaileditingfield,
                      SizedBox(
                        height: 20,
                      ),
                      passwordeditingfield,
                      SizedBox(
                        height: 20,
                      ),
                      confirpasswordfield,
                      SizedBox(
                        height: 20,
                      ),
                      signupbutton,
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("Already have an account "),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => Tab()));
                      //       },
                      //       child: Text(
                      //         "Login",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //             color: Colors.blueAccent.shade200),
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  )),
            ),
            Container(
              child: Image(
                image: AssetImage(
                  "assets/images/bottom-onbording.png",
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  signUp(
    String email,
    String password,
  ) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }

  }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    Usermodel usermodel = Usermodel();

    //writing all the values
    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.firstname = firstnamecontroller.text;
    usermodel.secondname = secondnamecontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account created succesfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Login_homepage()),
        (route) => false);
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          color: Colors.teal,
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}