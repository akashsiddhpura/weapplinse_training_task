import 'package:flutter/material.dart';
import 'package:weekly_task/week2/customnav.dart';
import 'package:weekly_task/week2/passingdata/page1.dart';

// ignore: must_be_immutable
class Page_2 extends StatefulWidget {
  String page1name, page1email;
  Page_2({required this.page1name, required this.page1email});

  @override
  State<Page_2> createState() => _Page_2State();
}

class _Page_2State extends State<Page_2> {
//   @override
  final _formky = GlobalKey<FormState>();

  TextEditingController _nameController2 = TextEditingController();

  TextEditingController _emailController2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController2.clear();
    _emailController2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
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
                controller: _nameController2,
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
                controller: _emailController2,
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
                        builder: (context) => Page_1(
                          page2email: _nameController2.text,
                          page2name: _emailController2.text,
                        ),
                      ),
                    );
                    setState(() {});
                  }

                  // }
                  print(_nameController2);
                  print(_emailController2);
                },
                color: Colors.black87,
                child: Text(
                  "submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text('name : ${widget.page1name}'),
              Text("email : ${widget.page1email}")
            ],
          ),
        ),
      ),
    );
  }
}
