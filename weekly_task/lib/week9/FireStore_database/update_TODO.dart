import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Update_TODO extends StatefulWidget {
  String id;
  String uTitle;
  String uDesc;
  Update_TODO(this.id, this.uTitle, this.uDesc);

  @override
  State<Update_TODO> createState() => _Update_TODOState();
}

class _Update_TODOState extends State<Update_TODO> {
  final CollectionReference _todos =
      FirebaseFirestore.instance.collection('TODOs');

  final firestoreInstance = FirebaseFirestore.instance;

  final _formkey = GlobalKey<FormState>();

  //controller
  TextEditingController _UpTODOTitle = TextEditingController();
  TextEditingController _UpTODODesc = TextEditingController();

  String? id;
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

  Widget UpdateButton() {
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
            if(_formkey.currentState!.validate()){
            showAlertDialog(context);
            DateTime now = DateTime.now();
            String createDate = DateFormat('MM-dd-yyyy HH:mm a').format(now);
            await firestoreInstance.collection("TODOs").doc(id).update({
              "title": _UpTODOTitle.text,
              "desc": _UpTODODesc.text,
            }).then((value) {
              print(id);
            });
            Navigator.pop(context);
            setState(() {
              Navigator.pop(context);
            });}
          },
          child: Text("Update",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    print(id);
    id = widget.id;
    _UpTODOTitle.text = widget.uTitle;
    _UpTODODesc.text = widget.uDesc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update TODO",
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
                      controller: _UpTODOTitle,
                      autofocus: false,
                      onSaved: (value) {
                        _UpTODOTitle.text = value!;
                      },
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
                      controller: _UpTODODesc,
                      onSaved: (value) {
                        _UpTODODesc.text = value!;
                      },
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
                UpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
