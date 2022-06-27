import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week2/serchbar.dart';
import 'package:weekly_task/week2/widgets/Listview.dart';

class Scafoldex extends StatefulWidget {
  const Scafoldex({Key? key}) : super(key: key);

  @override
  _scafoldexState createState() => _scafoldexState();
}

class _scafoldexState extends State<Scafoldex> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TabController(length: listview.length, vsync: this);
    _controller.addListener(() {
      print(_controller.index);
    });
  }

  var _volume = 0;
  List<Widget> listview = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "This is text widgets",
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          Text(
            "colored text",
            style: TextStyle(
                fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "elevated button",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Divider(height: 10),
          FlatButton(
            onPressed: () {},
            child: Text("flate button"),
            color: Colors.blue,
          ),
          Divider(height: 10),
          RaisedButton(
            padding: EdgeInsets.all(8),
            onPressed: () {},
            child: Text(
              "raised button",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(height: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.volume_up),
            iconSize: 50,
          ),
          Text("icon button"),
          Divider(height: 10),
          InkWell(
            splashColor: Colors.deepPurple,
            highlightColor: Colors.pink,
            child: Icon(
              Icons.ring_volume,
              size: 50,
            ),
            onTap: () {},
          ),
          Text("inkwell button"),
        ],
      ),
    ),
    Center(
      child: Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange,
              offset: Offset(6.0, 6.0),
            ),
          ],
        ),
        child: Text(
          "container demo",
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
    Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage('assets/images/profile.jpg'),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage('assets/images/profile.jpg'),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/profile.jpg'),
                      height: 300,
                      width: 600,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/profile.jpg'),
                      height: 300,
                      width: 600,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
    Center(
      child: Carddemo(),
    ),
    Center(child: AlertDialogedemo()),
    Center(
      child: Listviewdemo(),
    ),
    Center(child: Stackdemo()),
    Center(
      child: DropdownList(),
    ),
    Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      color: Colors.red,
                      height: 80,
                    ),
                    Container(
                      color: Colors.blue,
                      height: 80,
                    ),
                    Container(
                      color: Colors.purple,
                      height: 80,
                    ),
                    Container(
                      color: Colors.pinkAccent,
                      height: 80,
                    ),
                    Container(
                      color: Colors.green,
                      height: 80,
                    ),
                    Container(
                      color: Colors.amber,
                      height: 80,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Container(color: Colors.red, height: 280, width: 100),
                      Container(color: Colors.blue, height: 280, width: 100),
                      Container(color: Colors.purple, height: 280, width: 100),
                      Container(
                          color: Colors.pinkAccent, height: 280, width: 100),
                      Container(color: Colors.green, height: 280, width: 100),
                      Container(color: Colors.amber, height: 280, width: 100),
                      Container(color: Colors.red, height: 280, width: 100),
                      Container(color: Colors.blue, height: 280, width: 100),
                      Container(color: Colors.purple, height: 280, width: 100),
                      Container(
                          color: Colors.pinkAccent, height: 280, width: 100),
                      Container(color: Colors.green, height: 280, width: 100),
                      Container(color: Colors.amber, height: 280, width: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Center(
      child: Searchbardemo(),
    ),
    Center(
      child: Stepperdemo(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scaffolds widgets",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5,
          indicatorColor: Colors.blue,
          padding: EdgeInsets.all(10),
          controller: _controller,
          isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.redAccent,
          ),
          tabs: [
            Tab(
              child: Text("tex"),
              icon: Icon(Icons.text_fields),
            ),
            Tab(
              child: Text("buttons"),
              icon: Icon(Icons.smart_button_sharp),
            ),
            Tab(
              child: Text("container demo"),
              icon: Icon(Icons.add_box),
            ),
            Tab(
              child: Text("image"),
              icon: Icon(Icons.image),
            ),
            Tab(
              child: Text("Card"),
              icon: Icon(Icons.album),
            ),
            Tab(
              child: Text("alert dialog"),
              icon: Icon(Icons.tab),
            ),
            Tab(
              child: Text("List & Gridview"),
              icon: Icon(Icons.face),
            ),
            Tab(
              child: Text("Stack"),
              icon: Icon(Icons.cabin),
            ),
            Tab(
              child: Text("DropDown"),
              icon: Icon(Icons.hd),
            ),
            Tab(
              child: Text("Column & row"),
              icon: Icon(Icons.sports_football),
            ),
            Tab(
              child: Text("Search bar"),
              icon: Icon(Icons.sports_cricket),
            ),
            Tab(
              child: Text("Stepper"),
              icon: Icon(Icons.golf_course),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _controller, children: listview),
      floatingActionButton: FloatingActionButton(
          elevation: 8, child: Icon(Icons.add), onPressed: () {}),
    );
  }
}

class Carddemo extends StatelessWidget {
  const Carddemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 180,
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.purple.shade100,
            shadowColor: Colors.purple,
            elevation: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.album,
                    size: 60,
                  ),
                  title: Text(
                    "Arijit singh",
                    style: TextStyle(fontSize: 30),
                  ),
                  subtitle: Text(
                    "best of arijit singh",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                        child: Text(
                          "Play",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {}),
                    RaisedButton(
                        child: Text(
                          "Pause",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {})
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertDialogedemo extends StatelessWidget {
  const AlertDialogedemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.topCenter,
            child: ElevatedButton(
                onPressed: () {
                  IosDialog(context);
                },
                child: Text("ios")),
          ),
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.topCenter,
            child: ElevatedButton(
                onPressed: () {
                  AndroidDialog(context);
                },
                child: Text("Android")),
          ),
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.topCenter,
            child: ElevatedButton(
                onPressed: () {
                  Customdialog(context);
                },
                child: Text("custom")),
          ),
        ],
      ),
    );
  }

  void AndroidDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete File"),
        content: Text("Are you sure you want to delete the file?"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Yes")),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"))
        ],
      ),
    );
  }

  void IosDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Delete File"),
          content: Text("Are you sure you want to delete the file?"),
          actions: [
            CupertinoDialogAction(
                child: Text("YES"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            CupertinoDialogAction(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void Customdialog(BuildContext context) {
    Dialog deletefile = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 200,
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Padding(
                padding: EdgeInsetsDirectional.all(15),
                child: Column(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 30,
                    ),
                    Title(
                      color: Colors.white,
                      child: Text(
                        "Delete File",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Are you sure you want to delete the file?",
                      style: TextStyle(fontSize: 15),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Delete"),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => deletefile);
  }
}

class Stackdemo extends StatelessWidget {
  const Stackdemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: 10,
            width: 10,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: Container(
              height: 100,
              width: 100,
              child: Text("1"),
              color: Colors.cyanAccent,
            ),
          ),
          Positioned(
            top: 20,
            left: 60,
            child: Container(
              height: 100,
              width: 100,
              child: Text("2"),
              color: Color.fromARGB(255, 216, 24, 255),
            ),
          ),
          Positioned(
            top: 60,
            left: 40,
            child: Container(
              child: Text("3"),
              height: 100,
              width: 100,
              color: Color.fromARGB(255, 24, 255, 82),
            ),
          ),
          Positioned(
              height: 600,
              left: 100,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: 100,
              )),
          Positioned(
              height: 510,
              left: 120,
              child: CircleAvatar(
                child: Text("2"),
              )),
          Positioned(
              height: 450,
              left: 170,
              child: CircleAvatar(
                child: Text("1"),
              )),
          Positioned(
              height: 610,
              left: 110,
              child: CircleAvatar(
                child: Text("3"),
              )),
          Positioned(
              height: 700,
              left: 130,
              child: CircleAvatar(
                child: Text("4"),
              )),
          Positioned(
              height: 700,
              left: 230,
              child: CircleAvatar(
                child: Text("5"),
              )),
          Positioned(
              height: 750,
              left: 180,
              child: CircleAvatar(
                child: Text("6"),
              )),
          Positioned(
              height: 600,
              left: 250,
              child: CircleAvatar(
                child: Text("7"),
              )),
          Positioned(
              height: 490,
              left: 230,
              child: CircleAvatar(
                child: Text("8"),
              )),
        ],
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({Key? key}) : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  String _chosenValue = "OPPO";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 212, 212),
      padding: const EdgeInsets.all(0.0),
      child: DropdownButton(
        dropdownColor: Color.fromARGB(255, 187, 251, 253),
        borderRadius: BorderRadius.circular(10),
        iconEnabledColor: Colors.blue,

        value: _chosenValue,
        // elevation: 15,
        style: TextStyle(color: Colors.black),
        items: <String>[
          'OPPO',
          'Redmi',
          'Apple',
          'Samsung',
          'VIVO',
          'Moto G',
          'Realme',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "Please choose a langauage",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue = value!;
          });
        },
      ),
    );
  }
}

class Stepperdemo extends StatefulWidget {
  const Stepperdemo({Key? key}) : super(key: key);

  @override
  State<Stepperdemo> createState() => _StepperdemoState();
}

class _StepperdemoState extends State<Stepperdemo> {
  int currentstep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        steps: getSteps(),
        type: StepperType.horizontal,
        currentStep: currentstep,
        onStepContinue: () {
          setState(() {
            final isLaststep = currentstep == getSteps().length - 1;
            if (isLaststep) {
              print("complete");
            } else {
              setState(() {
                currentstep += 1;
              });
            }
          });
        },
        onStepCancel: currentstep == 0
            ? null
            : () => setState(() {
                  currentstep -= 1;
                }),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text('Account'),
            content: Container(
              child: Text(
                "Account",
                style: TextStyle(fontSize: 30),
              ),
            ),
            isActive: currentstep >= 0),
        Step(
            title: Text('Address'),
            content: Container(
              child: Text(
                "Address",
                style: TextStyle(fontSize: 30),
              ),
            ),
            isActive: currentstep >= 1),
        Step(
            title: Text(
              'complete',
            ),
            content: Container(
              child: Text(
                "Complete",
                style: TextStyle(fontSize: 30),
              ),
            ),
            isActive: currentstep >= 2),
      ];
}
