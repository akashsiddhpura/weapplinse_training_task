import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week9/RealTime_database/add_emp.dart';
import 'package:weekly_task/week9/RealTime_database/emp_update.dart';

class RealtimeDatabaseUI extends StatefulWidget {
  const RealtimeDatabaseUI({Key? key}) : super(key: key);

  @override
  State<RealtimeDatabaseUI> createState() => _RealtimeDatabaseUIState();
}

class _RealtimeDatabaseUIState extends State<RealtimeDatabaseUI> {
  late DatabaseReference refDataInstance;

  @override
  void initState() {
    refDataInstance = FirebaseDatabase.instance.ref("employee");

    // TODO: implement initState
    super.initState();
  }

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RealTime Database",style: TextStyle(color: Colors.teal.shade200),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.teal.shade200,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: FirebaseAnimatedList(
          itemBuilder: (context, DataSnapshot snapshot, animation, index) {
            var data = snapshot.value;
            print(snapshot.value);
            //
            final a = Map.from(json.decode(json.encode(snapshot.value)));
            print(a);

            bool loaded = false;

            Widget cacheImg(){
              return CachedNetworkImage(imageUrl: a["url"]);
            }


            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                shadowColor: Colors.teal,
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [ Colors.white,Colors.teal.shade100,],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "ID : ${a["id"].toString()}",
                                  //   style: TextStyle(fontWeight: FontWeight.bold),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      a["url"] != null ?
                                      Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40)),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                a["url"],
                                                progressIndicatorBuilder:
                                                    (context, url, downloadProgress) => Image.asset(
                                                  "assets/images/avtar.png",
                                                  fit: BoxFit.contain,
                                                ),
                                                errorWidget: (context, url, error) => CircleAvatar(
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 30,
                                                  ),
                                                )),
                                          ),
                                          // margin: EdgeInsetseInsets.only(top: 100, bottom: 70),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFFFF),

                                            borderRadius: BorderRadius.circular(40),
                                            // image: DecorationImage(
                                            //   image: NetworkImage(a["url"]),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.teal,
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) :
                                      Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40)),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFFFF),
                                            borderRadius: BorderRadius.circular(40),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/avtar.png"),
                                              fit: BoxFit.contain,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.teal,
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Text(
                                        a["designation"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23),
                                      ),
                                      Text(
                                        a["gender"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${a["name"].toString()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${a["mobile"].toString()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${a["email"].toString()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.currency_rupee),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${a["salary"].toString()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black87,
                            onPressed: () async {
                              await FirebaseAnalytics.instance.logEvent(name: "update_page_open", parameters: {
                                "employee_id" : "update emp id - ${a["id"]}"
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateEmp( a["url"],a["id"],a["name"], a["designation"], a["mobile"], a["salary"], a["email"], a["gender"],)));
                            },
                          )),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () async {
                                await FirebaseAnalytics.instance.logEvent(name: "employee_data_deleted", parameters: {
                                  "employee_id" : "deleted emp id - ${a["id"]}"
                                });
                                showAlertDialog(context);
                                await refDataInstance
                                    .child(snapshot.key!)
                                    .remove();
                                setState(() {
                                  Navigator.pop(context);
                                });



                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          query: refDataInstance,
          shrinkWrap: true,
          defaultChild: Center(
            child: CircularProgressIndicator(color: Colors.teal,),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await FirebaseAnalytics.instance.setCurrentScreen(screenName: "Add employee page", screenClassOverride:  "open add emp page");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEmp()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.teal.shade300,
      ),
    );
  }
}
