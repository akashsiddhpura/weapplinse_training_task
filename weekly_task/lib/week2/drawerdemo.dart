// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:weekly_task/week2/fav.dart';

class Drawerdemo extends StatefulWidget {
  const Drawerdemo({Key? key}) : super(key: key);

  @override
  _DrawerdemoState createState() => _DrawerdemoState();
}

class _DrawerdemoState extends State<Drawerdemo> {
  String name = "aakash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("drawer demo"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 30),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Aakash Siddhpura",
                style: TextStyle(fontSize: 25),
              ),
              accountEmail: Text("aksiddhoura@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    color: Colors.black45,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1628407748704-8b6e497245b7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1927&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("favorite"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fav()));
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("friends"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Alert !"),
                      content: Text("This is alerts msg example"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            });
                          },
                          child: Text("ok"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("share"),
              onTap: () {
                setState(() {
                  Navigator.of(context).pop(name = "siddhpura");
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.request_page),
              title: Text("request"),
            ),
            Divider(
              endIndent: 10,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("setting"),
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text("policy"),
            ),
            Divider(
              endIndent: 10,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("exit"),
            )
          ],
        ),
      ),
    );
  }
}
