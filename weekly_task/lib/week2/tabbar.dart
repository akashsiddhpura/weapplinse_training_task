import 'package:flutter/material.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 10, vsync: this);
    _controller.addListener(() {
      print(_controller.index);
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.dispose();
  // }

  List<Widget> listview = [
    Center(
      child: Text(
        "tab 1",
        style: TextStyle(fontSize: 30),
      ),
    ),
    Center(
      child: Text(
        "tab 2",
        style: TextStyle(fontSize: 30),
      ),
    ),
    Center(
        child: Text(
      "tab 3",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 5",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 4",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 6",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 7",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 8",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 9",
      style: TextStyle(fontSize: 30),
    )),
    Center(
        child: Text(
      "tab 10",
      style: TextStyle(fontSize: 30),
    )),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tab bar demo",
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
                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent),
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
              Tab(
                icon: Icon(Icons.sports_cricket),
              ),
              Tab(
                icon: Icon(Icons.alarm),
              ),
              Tab(
                icon: Icon(Icons.backpack),
              ),
              Tab(
                icon: Icon(Icons.garage),
              ),
              Tab(
                icon: Icon(Icons.face),
              ),
              Tab(
                icon: Icon(Icons.cabin),
              ),
              Tab(
                icon: Icon(Icons.hd),
              ),
              Tab(
                icon: Icon(Icons.keyboard),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _controller, children: listview),
      ),
    );
  }
}
