import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LifeCycleExm extends StatefulWidget {
  @override
  _LifeCycleExmState createState() => _LifeCycleExmState();
}

class _LifeCycleExmState extends State<LifeCycleExm>
    with WidgetsBindingObserver {
  var statedata;
  @override
  void initState() {
    super.initState();
    initToast();
    WidgetsBinding.instance!.addObserver(this);
    print("initState");
  }

  void initToast() {
    Fluttertoast.showToast(
        msg: "This is initstate",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print('$state');
    switch (state) {
      case AppLifecycleState.paused:
        {
          statedata = state;
          Fluttertoast.showToast(
              msg: "app is  $statedata",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);
        }

        break;
      case AppLifecycleState.resumed:
        {
          statedata = state;
          Fluttertoast.showToast(
              msg: "app is  $statedata",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);
        }

        break;
      case AppLifecycleState.inactive:
        {
          statedata = state;
          Fluttertoast.showToast(
              msg: "app is  $statedata",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);
        }

        break;
      case AppLifecycleState.detached:
        {
          statedata = state;
          Fluttertoast.showToast(
              msg: "app is  $statedata",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);
        }

        break;
      default:
    }
  }

  // void ChangestateToast() {
  //   Fluttertoast.showToast(
  //       msg: "app is  $statedata",
  //       toastLength: Toast.LENGTH_LONG,
  //       backgroundColor: Colors.green);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   super.dispose();
  //   Disposetoast();
  //   print("dispose");
  // }

  // void Disposetoast() {
  //   Fluttertoast.showToast(
  //       msg: "app is dispose",
  //       toastLength: Toast.LENGTH_LONG,
  //       backgroundColor: Colors.green);
  // }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
    Deactivatetoast();
  }

  void Deactivatetoast() {
    Fluttertoast.showToast(
        msg: "app is deactivate",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green);
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Buildtoast();
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Lifecycle",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void Buildtoast() {
    Fluttertoast.showToast(
        msg: "app is in build ",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green);
  }
}
