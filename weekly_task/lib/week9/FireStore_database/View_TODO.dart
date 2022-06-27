import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:weekly_task/week9/FireStore_database/Add_TODO.dart';
import 'package:weekly_task/week9/FireStore_database/update_TODO.dart';

class View_TODO extends StatefulWidget {
  const View_TODO({Key? key}) : super(key: key);

  @override
  State<View_TODO> createState() => _View_TODOState();
}

class _View_TODOState extends State<View_TODO> {
  final CollectionReference _todos =
      FirebaseFirestore.instance.collection('TODOs');

  final firestoreInstance = FirebaseFirestore.instance;

  bool isComplete = false;
  bool isStatus = false;
  String status = "create";

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

  Future<void> _deleteTodos(String todoId) async {
    await _todos.doc(todoId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "TODOs",
          style: TextStyle(color: Colors.deepPurple.shade200),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.deepPurple.shade200,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add_TODO()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
            stream: _todos.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];

                    String date = documentSnapshot['create_Date'];

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onLongPress: () async {
                          DateTime now = DateTime.now();
                          String doneDate =
                              DateFormat('MM-dd-yyyy HH:mm').format(now);
                          if (documentSnapshot['status'] == "pending") {
                            await firestoreInstance
                                .collection("TODOs")
                                .doc(documentSnapshot.id)
                                .update(
                                    {"done_Date": doneDate, "status": "Done"});
                            isStatus = true;
                            setState(() {});
                          } else
                            Fluttertoast.showToast(
                                msg: "This task already done",
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.deepPurple.shade200);
                        },
                        child: Card(
                          shadowColor: Colors.deepPurple.shade200,
                          clipBehavior: Clip.antiAlias,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.white,
                                  Colors.deepPurple.shade100,
                                ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  documentSnapshot['status'] == "Done"
                                      ? Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                documentSnapshot['status'],
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                documentSnapshot['status'],
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        documentSnapshot['title'],
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    documentSnapshot['desc'],
                                    style: TextStyle(color: Colors.black45),
                                    textAlign: TextAlign.left,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(documentSnapshot['desc'],style: TextStyle(color: Colors.black45),),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.alarm_rounded,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                              "${documentSnapshot['create_Date']}",
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                      documentSnapshot['done_Date'] != ""
                                          ? Row(
                                              children: [
                                                Icon(
                                                  Icons.alarm_on_rounded,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                    " ${documentSnapshot['done_Date']}",
                                                    textAlign: TextAlign.start)
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(Icons.edit),
                                          color: Colors.black87,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Update_TODO(
                                                  documentSnapshot.id,
                                                  documentSnapshot["title"],
                                                  documentSnapshot["desc"],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () async {
                                            CircularProgressIndicator();
                                            await _deleteTodos(
                                                documentSnapshot.id);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    //   Card(
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text("Create Date : ${documentSnapshot['create_Date']}",textAlign: TextAlign.start),
                    //         ],
                    //       ),
                    //       ListTile(
                    //         title: Text(documentSnapshot['title'],style: TextStyle(fontSize: 30),),
                    //         subtitle: Text(documentSnapshot['desc']),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
