import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';

class Resetpassword extends StatefulWidget {
  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController resetcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //reset button
    final resetbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Colors.black,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 80.w,
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: resetcontroller.text)
                .then(
                  (value) => Navigator.pop(
                    context,
                    // MaterialPageRoute(
                  //   //   builder: ((context) => Logintab()),
                  //   ),
                  // ),
                ),);
          }
          ;
        },
        child: Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Enter your email address below to reset password",
                  style: TextStyle(fontSize: 18, color: Colors.black38),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    cursorColor: Colors.teal,
                    controller: resetcontroller,
                    // autofocus: false,
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
                      resetcontroller.text = value!;
                    },
                    // textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                resetbutton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
