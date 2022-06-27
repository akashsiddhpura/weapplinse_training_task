import 'package:flutter/material.dart';
import 'package:weekly_task/week2/customnav.dart';
import 'package:weekly_task/week2/passingdata/page2.dart';

class Page_1 extends StatefulWidget {
  final String page2name;
  final String page2email;

  Page_1({required this.page2name, required this.page2email});

  @override
  State<Page_1> createState() => _Page_1State();
}

class _Page_1State extends State<Page_1> {
  final _formky = GlobalKey<FormState>();

  TextEditingController _nameController1 = TextEditingController();

  TextEditingController _emailController1 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formky,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController1,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  RegExp regex = RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return ("please enter name");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("name must be 3 character");
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController1,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: 'email',
                ),

                validator: (value) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = RegExp(pattern);
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!regex.hasMatch(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  final isValid = _formky.currentState!.validate();
                  if (isValid) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page_2(
                          page1name: _nameController1.text,
                          page1email: _emailController1.text,
                        ),
                      ),
                    );
                    setState(() {});
                  }

                  // }
                  print(_nameController1);
                  print(_emailController1);
                },
                color: Colors.black87,
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text('name : ${widget.page2name}'),
              Text("email : ${widget.page2email}")
            ],
          ),
        ),
      ),
    );
  }
}
