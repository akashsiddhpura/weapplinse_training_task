import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;

  String contain = "Custom Drawer";

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    offset = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero).animate(
        CurvedAnimation(parent: controller!, curve: Curves.decelerate));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Drawer"),
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              switch (controller!.status) {
                case AnimationStatus.completed:
                  controller!.reverse();
                  break;
                case AnimationStatus.dismissed:
                  controller!.forward();
                  break;
                default:
              }
            },
            icon: Icon(Icons.menu),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            switch (controller!.status) {
              case AnimationStatus.completed:
                controller!.reverse();
                break;
              // case AnimationStatus.dismissed:
              //   controller!.forward();
              //   break;
              default:
            }
          },
          child: Container(
            height: 800,
            width: 500,
            color: Colors.white,
            child: Stack(
              children: [
                Center(
                  child: Text(contain),
                ),
                _drawer(context),
              ],
            ),
          ),
        ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SlideTransition(
            position: offset!,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 800,
                width: 300,
                color: Color.fromARGB(255, 198, 244, 255),
                child: Column(
                  children: [
                    Container(
                      color: Colors.lightBlueAccent,
                      height: 200,
                      width: 300,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 30,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: 40,
                              child: Text(
                                "AK",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 120,
                            child: Text(
                              "Aakash Siddhpura",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 150,
                            child: Text("aksiddhpura410@gamil.com"),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contain = "Home";
                          switch (controller!.status) {
                            case AnimationStatus.completed:
                              controller!.reverse();
                              break;

                            default:
                          }
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Home"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contain = "Profile";
                          switch (controller!.status) {
                            case AnimationStatus.completed:
                              controller!.reverse();
                              break;

                            default:
                          }
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Profile"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contain = "Abouts";
                          switch (controller!.status) {
                            case AnimationStatus.completed:
                              controller!.reverse();
                              break;

                            default:
                          }
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text("Abouts"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
