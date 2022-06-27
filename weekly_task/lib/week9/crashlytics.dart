import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week2/widgets/scaffold.dart';

class Firebase_Crashlytics extends StatefulWidget {
  const Firebase_Crashlytics({Key? key}) : super(key: key);

  @override
  State<Firebase_Crashlytics> createState() => _Firebase_CrashlyticsState();
}

class _Firebase_CrashlyticsState extends State<Firebase_Crashlytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Crashlytics"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  FirebaseCrashlytics.instance.crash();
                },
                child: Text("make crash"),
                color: Colors.teal.shade200,
              ),
              MaterialButton(
                onPressed: () async {
                  // Set a key to a string.
                  await FirebaseCrashlytics.instance
                      .setCustomKey('str_key', 'hello');

// Set a key to a boolean.
                  await FirebaseCrashlytics.instance
                      .setCustomKey("bool_key", true);

// Set a key to an int.
                  await FirebaseCrashlytics.instance.setCustomKey("int_key", 1);

// Set a key to a long.
                  await FirebaseCrashlytics.instance
                      .setCustomKey("int_key", 99989);

// Set a key to a float.
                  await FirebaseCrashlytics.instance
                      .setCustomKey("float_key", 1.0);

// Set a key to a double.
                  FirebaseCrashlytics.instance.setCustomKey("double_key", 1.0);
                  await FirebaseCrashlytics.instance
                      .log("hey this is custom log message");
                },
                child: Text("log"),
                color: Colors.teal.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
