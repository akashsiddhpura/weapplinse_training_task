import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_task/week9/FireStore_database/View_TODO.dart';

class Add_TODO extends StatefulWidget {
  const Add_TODO({Key? key}) : super(key: key);

  @override
  State<Add_TODO> createState() => _Add_TODOState();
}

class _Add_TODOState extends State<Add_TODO> {
  final firestoreInstance = FirebaseFirestore.instance;

  final _formkey = GlobalKey<FormState>();

  //controller
  TextEditingController _TODOTitle = TextEditingController();
  TextEditingController _TODODesc = TextEditingController();
  //validation
  bool isTitleValid(String title) => title.length > 5;
  bool isDescValid(String? desc) => desc!.length > 10;

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

  Widget AddButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(7),
        color: Colors.deepPurple.shade200,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              showAlertDialog(context);
              DateTime now = DateTime.now();
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              String status = "pending";

              String createDate = DateFormat('MM-dd-yyyy HH:mm').format(now);

              await firestoreInstance.collection("TODOs").doc(id).set({
                "id": id,
                "title": _TODOTitle.text,
                "desc": _TODODesc.text,
                "status": status,
                "create_Date": createDate.toString(),
                "done_Date": ""
              }).then((value) {
                print(id);
              });
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
            }
          },
          child: Text("Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add TODO",
          style: TextStyle(color: Colors.deepPurple.shade200),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.deepPurple.shade200,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Card(
                  color: Colors.deepPurple.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _TODOTitle,
                      autofocus: false,
                      decoration: InputDecoration(
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.teal),
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          border: InputBorder.none,
                          hintText: 'Title'),
                      validator: (title) {
                        if (isTitleValid(title!))
                          return null;
                        else
                          return 'Title must be 5+ character';
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.deepPurple.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      validator: (desc) {
                        if (isDescValid(desc))
                          return null;
                        else
                          return 'Description must be 10+ character';
                      },
                      controller: _TODODesc,
                      decoration: InputDecoration(
                          focusColor: Colors.grey,
                          fillColor: Colors.grey,
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.teal),
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          border: InputBorder.none,
                          hintText: 'Type a description...'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AddButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
