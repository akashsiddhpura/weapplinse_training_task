import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:weekly_task/week2/demoslider.dart';

enum BestTechno { Flutter, Android }

class Customcontrols extends StatefulWidget {
  const Customcontrols({Key? key}) : super(key: key);

  @override
  State<Customcontrols> createState() => _CustomcontrolsState();
}

class _CustomcontrolsState extends State<Customcontrols> {
  bool isSwitched = false;
  bool ishindi = false;
  bool isgujarati = false;
  bool isenglish = false;
  Color backcolor = Colors.white;

  BestTechno? _tech = BestTechno.Flutter;
  void switchActivity(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Custom control",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Default Control",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Switch",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Transform.scale(
                  scale: 2,
                  child: Switch(
                    value: isSwitched,
                    onChanged: switchActivity,
                    activeColor: Colors.lime,
                    activeTrackColor: Color.fromARGB(255, 204, 115, 255),
                    activeThumbImage: AssetImage("assets/images/peter.jpg"),
                    inactiveThumbImage: AssetImage("assets/images/profile.jpg"),
                    splashRadius: 30,
                    inactiveThumbColor: Color.fromARGB(255, 255, 162, 193),
                    inactiveTrackColor: Color.fromARGB(255, 255, 200, 118),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "CheckBox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Checkbox(
                            value: ishindi,
                            onChanged: (value) {
                              setState(() {
                                ishindi = value!;
                              });
                            }),
                        Text("hindi"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Checkbox(
                            value: isgujarati,
                            onChanged: (value) {
                              setState(() {
                                isgujarati = value!;
                              });
                            }),
                        Text("gujarati"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Checkbox(
                            value: isenglish,
                            onChanged: (value) {
                              setState(() {
                                isenglish = value!;
                              });
                            }),
                        Text("English"),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "Radio Button",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 90),
                    title: Text("Flutter"),
                    leading: Radio(
                        value: BestTechno.Flutter,
                        groupValue: _tech,
                        onChanged: (value) {
                          setState(() {
                            _tech = value as BestTechno?;
                          });
                        }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 90),
                    title: Text("Android"),
                    leading: Radio(
                        value: BestTechno.Android,
                        groupValue: _tech,
                        onChanged: (value) {
                          setState(() {
                            _tech = value as BestTechno?;
                          });
                        }),
                  )
                ],
              ),
              Divider(
                color: Colors.black87,
              ),
              Text(
                "Custom Control",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Custom Switch",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 65,
                width: 120,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSwitched = !isSwitched;
                                  backcolor =
                                      Color.fromARGB(255, 255, 255, 255);
                                });
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: isSwitched
                                        ? Colors.grey
                                        : Color.fromARGB(255, 204, 0, 255),
                                    maxRadius: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: isSwitched
                                          ? Container(
                                              child: Center(
                                                  child: Text(
                                                "on",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                            )
                                          : Icon(
                                              Icons.dark_mode,
                                              size: 18.0,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSwitched = !isSwitched;
                                  backcolor =
                                      Color.fromARGB(255, 181, 124, 255);
                                });
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor: isSwitched
                                        ? Color.fromARGB(255, 255, 174, 0)
                                        : Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: isSwitched
                                          ? Icon(
                                              Icons.light_mode,
                                              size: 18.0,
                                              color: Colors.white,
                                            )
                                          : Container(
                                              child: Center(
                                                child: Text(
                                                  "off",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Custom CheckBox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ishindi = !ishindi;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ishindi ? Colors.green : Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ishindi
                                  ? Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color: Colors.white,
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Hindi")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isgujarati = !isgujarati;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isgujarati ? Colors.green : Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: isgujarati
                                  ? Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color: Colors.white,
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("gujarati")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isenglish = !isenglish;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isenglish ? Colors.green : Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: isenglish
                                  ? Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color: Colors.white,
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("english")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
          color: backcolor,
        ),
      ),
    );
  }
}
