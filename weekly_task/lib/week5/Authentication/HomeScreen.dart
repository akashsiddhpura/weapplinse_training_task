import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_task/week5/Authentication/AuthController.dart';

class SocialHomePage extends StatefulWidget {
  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedpref();
  }

  sharedpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString("providerId").toString();
    email = prefs.getString("email").toString();
    name = prefs.getString("name").toString();
    image = prefs.getString("photoURL").toString();
    setState(() {});
  }

  String data = "";
  String name = "";
  String email = "";
  String image = "";

  SocialAuthController _con = Get.put(SocialAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  // ignore: unnecessary_null_comparison
                  backgroundImage: image != null ? NetworkImage(image) : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                " ${name}\n ${email}",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.black87,
                elevation: 5,
                child: FlatButton.icon(
                  onPressed: () {
                      _con.signout();
                  },
                  icon: Icon(
                    FontAwesomeIcons.signOut,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Sign out",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
