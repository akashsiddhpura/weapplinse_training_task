import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekly_task/week11/state_management/GetX/getx2.dart';
import 'package:weekly_task/week11/state_management/GetX/getxController.dart';

class GetXDemo extends StatefulWidget {
  const GetXDemo({Key? key}) : super(key: key);

  @override
  State<GetXDemo> createState() => _GetXDemoState();
}

class _GetXDemoState extends State<GetXDemo> {
  final getcontroller = Get.put(GetXDemoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Demo"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                getcontroller.count.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(GetX2());
                },
                child: Text("next page"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getcontroller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
