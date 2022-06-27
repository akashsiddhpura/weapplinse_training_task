import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationDemo extends StatefulWidget {
  const LocalizationDemo({Key? key}) : super(key: key);

  @override
  State<LocalizationDemo> createState() => _LocalizationDemoState();
}

class _LocalizationDemoState extends State<LocalizationDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  set() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appbar".tr().toString()),
        backgroundColor: Colors.black87,
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('hindi'),
                onTap: () {
                  context.locale = Locale('hi', 'IN');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('hi', 'IN');
                    set();
                  });
                  set();
                },
              ),
              PopupMenuItem(
                child: Text('gujarati'),
                onTap: () {
                  context.locale = Locale('gu', 'IN');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('gu', 'IN');
                    set();
                  });
                  set();
                },
              ),
              PopupMenuItem(
                child: Text('panjabi'),
                onTap: () {
                  context.locale = Locale('pa', 'IN');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('pa', 'IN');
                    set();
                  });
                  set();
                },
              ),
              PopupMenuItem(
                child: Text('kannad'),
                onTap: () {
                  context.locale = Locale('kn', 'IN');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('kn', 'IN');
                    set();
                  });
                  set();
                },
              ),
              PopupMenuItem(
                child: Text('marathi'),
                onTap: () {
                  context.locale = Locale('mr', 'IN');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('mr', 'IN');
                    set();
                  });
                  set();
                },
              ),
              PopupMenuItem(
                child: Text('english'),
                onTap: () {
                  context.locale = Locale('en', 'US');
                  Future.delayed(Duration(milliseconds: 200),(){
                    context.locale = Locale('en', 'US');
                    set();
                  });
                  set();
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.tealAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        "title".tr().toString().toUpperCase(),
                        style: TextStyle(fontSize: 30),
                      ),
                      Divider(),
                      Text(
                        "desc".tr().toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
