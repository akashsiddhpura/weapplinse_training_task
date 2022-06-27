import 'package:flutter/material.dart';

class Formvalidation extends StatefulWidget {
  const Formvalidation({Key? key}) : super(key: key);

  @override
  _FormvalidationState createState() => _FormvalidationState();
}

class _FormvalidationState extends State<Formvalidation> {
  final formkey = GlobalKey<FormState>();
  String usermail = ' ', userpwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login page",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  buildemail(),
                  SizedBox(
                    height: 15,
                  ),
                  buildpassword(),
                  SizedBox(
                    height: 15,
                  ),
                  submitbtn()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildemail() => TextFormField(
        decoration: InputDecoration(
          labelText: 'email',
          border: OutlineInputBorder(),
        ),
        maxLength: 30,
        validator: (value) {
          final Pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(Pattern);
          if (value!.isEmpty) {
            return 'enter email';
          }
          if (!regExp.hasMatch(value)) {
            return 'enter valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() {
          usermail = value!;
        }),
      );
  Widget buildpassword() => TextFormField(
        decoration: InputDecoration(
          labelText: 'password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 7) {
            return 'password at least 8 character';
          } else if (value.length > 15) {
            return 'password under 15 character';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => userpwd = value!),
      );
  Widget submitbtn() => RaisedButton(
        child: Text("submit"),
        onPressed: () {
          final isValid = formkey.currentState!.validate();

          if (isValid) {
            formkey.currentState!.save();

            final message = 'email : $usermail \n password: $userpwd';

            final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.brown);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      );
}
