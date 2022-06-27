import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Facebook extends StatefulWidget {
  const Facebook({Key? key}) : super(key: key);

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  bool _isloggedIn = false;
  late Map? user;
  FacebookLogin facebooklogin = FacebookLogin();

  @override
  void initState() {
    super.initState();
  }

  loginwithfb() async {
    print("facebook");
    try {
      final result = await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success && _isloggedIn == false) {
        // Future<AccessToken?> accessToken = FacebookAuth.instance.accessToken;
        final userdata = await FacebookAuth.instance.getUserData();
        print(userdata);
        setState(() {
          user = userdata;
          _isloggedIn = true;
        });
      } else if (result.status == LoginStatus.cancelled) {
        setState(() {
          _isloggedIn = false;
        });
      }
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    } catch (error) {
      print(error);
      setState(() {
        _isloggedIn = false;
      });
    }

  }

  _logout() async {
    await facebooklogin.logOut();
    await FacebookAuth.instance.logOut();

    print("logout done");
    // await _auth.signOut();
    setState(() {
      _isloggedIn = false;

      user = null;
    });
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: Center(
          child: _isloggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Facebook",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(user!["picture"]["data"]["url"]),
                      // child: Image.network(
                      //   user["picture"]["data"]["url"],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '${user!['name']}\n   ${user!['email']}',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RaisedButton(
                      child: Text("Logout"),
                      onPressed: () {
                        _logout();
                      },
                    ),
                  ],
                )
              : Center(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: FlatButton.icon(
                        onPressed: () {
                          loginwithfb();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        label: Text("Login With Facebook")),
                  ),
                ),
        ),
      )),
    );
  }
}
