import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekly_task/week11/state_management/GetX/getxController.dart';

class GetX2 extends StatefulWidget {
  const GetX2({Key? key}) : super(key: key);

  @override
  State<GetX2> createState() => _GetX2State();
}

class _GetX2State extends State<GetX2> {
  final GetXDemoController get2Controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Page 2"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                get2Controller.count.string,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "getx snackbar demo",
                    "snackbar message",
                    backgroundColor: Colors.teal.shade100,
                    icon: Icon(Icons.android),
                  );
                },
                child: Text("getx snackbar")),
            ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(title: "GetX Dialog");
                },
                child: Text("getx snackbar")),
            ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      height: 150,
                      color: Colors.teal.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "test 1",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "test 2",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "test 3",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "test 4",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    enableDrag: true,
                  );
                },
                child: Text("getx bottomSheet"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: get2Controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
