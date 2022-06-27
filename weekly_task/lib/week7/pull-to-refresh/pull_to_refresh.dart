import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PullToRefresh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PullToRefreshState();
  }
}

class _PullToRefreshState extends State<PullToRefresh> {
  int refreshData = 5;
  final String apiUrl = "https://randomuser.me/api/?results=";

  List<dynamic> _users = [];

  void fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl+ refreshData.toString()));
    setState(() {
      refreshData++;
      _users = json.decode(result.body)['results'];
    });
  }

  String _name(dynamic user) {
    return
        user['name']['first'] +
        " " +
        user['name']['last'];
  }


  String _email(dynamic user) {
    return user['email'];
  }
  String _age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to Refresh'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: _users.length != 0
            ? RefreshIndicator(
          child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        tileColor: Colors.grey.shade300,
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                _users[index]['picture']['large'])),
                        title: Text(_name(_users[index])),
                        subtitle: Text(_users[index]['email']),
                        trailing: Text(_age(_users[index])),
                      )
                    ],
                  ),
                );
              }),
          onRefresh: _getData,
        )
            : Center(child: CircularProgressIndicator())
      ),
    );
  }
}