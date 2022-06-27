import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;

class FaceBookLoginDemo extends StatefulWidget {
  @override
  _FaceBookLoginDemoState createState() => _FaceBookLoginDemoState();
}

class _FaceBookLoginDemoState extends State<FaceBookLoginDemo> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String message = 'Getting Session...';
  String f_name = '';
  String l_name = '';
  String email = '';
  String image = '';
  String buttonText = "Login";
  bool login = false;
  bool alreadyLogin = false;
  bool gettingSession = true;

  @override
  void initState() {
    super.initState();
    autoLoginCheck();
  }

  Future<void> autoLoginCheck() async {
    final bool loginCheck = await facebookSignIn.isLoggedIn;
    setState(() {
      alreadyLogin = loginCheck;
    });

    alreadyLogin ? getDataIfAlreadyLogin() : faslse();
  }

  void faslse() {
    setState(() {
      gettingSession = false;
    });
  }

  Future<void> getDataIfAlreadyLogin() async {
    var alreadyLoginToken = await facebookSignIn.accessToken;
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,email,picture&access_token=${alreadyLoginToken!.token}'));
    final profile = jsonDecode(graphResponse.body);
    print(profile['picture']['data']['url']);
    print(profile['first_name']);
    print(graphResponse.body);
    setState(() {
      login = true;
      gettingSession = false;
      f_name = profile['first_name'];
      l_name = profile['last_name'];
      email = profile['email'];
      image = profile['picture']['data']['url'];
      buttonText = "Logout";
    });
    _showMessage('''
         Logged in!
         Token: ${alreadyLoginToken.token}
         User id: ${alreadyLoginToken.userId}
         Expires: ${alreadyLoginToken.expires}
         Permissions: ${alreadyLoginToken.permissions}
         Declined permissions: ${alreadyLoginToken.declinedPermissions}
         ''');
  }

  Future<Null> _login() async {
    // final FacebookLoginResult result = await facebookSignIn.logIn(permissions: ['email']);
    final result = await FacebookAuth.instance.login(permissions: ['email']);

    switch (result.status) {
      case LoginStatus.success:
        final AccessToken? accessToken = result.accessToken;
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=first_name,last_name,email,picture&access_token=${accessToken!.token}'));
        final profile = jsonDecode(graphResponse.body);
        print(profile['picture']['data']['url']);
        print(graphResponse.body);
        setState(() {
          login = true;
          f_name = profile['first_name'];
          l_name = profile['last_name'];
          email = profile['email'];
          image = profile['picture']['data']['url'];
          buttonText = "Logout";
        });
        _showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.grantedPermissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        print(accessToken.token);
        break;
      case LoginStatus.cancelled:
        _showMessage('Login cancelled by the user.');
        break;
      case LoginStatus.failed:
        setState(() {
          message = result.message!;
        });
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.message}');
        break;
      case LoginStatus.operationInProgress:
        // TODO: Handle this case.
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut().then((value) {
      setState(() {
        login = false;
        f_name = '';
        l_name = '';
        email = '';
        image = '';
        buttonText = "Login";
      });
    }).catchError((onError) {
      print("Error 1");
    });
    _showMessage('Logged out.');
  }

  void _showMessage(String msg) {
    setState(() {
      message = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Facebook',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gettingSession
                ? CircularProgressIndicator()
                : login
                    ? Container(
                        child: Column(
                          children: [
                            Text(
                              "Facebook",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            image != ""
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(image),
                                    radius: 50,
                                    backgroundColor: Color(0x00000000),
                                  )
                                : Container(),
                            Text(
                              "${f_name}  ${l_name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 20),
                            ),
                            // Text(message),
                            RaisedButton(
                              onPressed: _logOut,
                              color: Color.fromARGB(255, 210, 209, 209),
                              child: new Text(buttonText),
                            )
                          ],
                        ),
                      )
                    : RaisedButton(
                        color: Color.fromARGB(255, 210, 209, 209),
                        onPressed: _login,
                        child: new Text(buttonText),
                      ),
          ],
        ),
      ),
    );
  }
}
