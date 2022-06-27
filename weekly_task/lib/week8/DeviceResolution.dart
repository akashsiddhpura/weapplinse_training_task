import 'package:flutter/material.dart';

class DeviceResolution extends StatefulWidget {
  const DeviceResolution({Key? key}) : super(key: key);

  @override
  State<DeviceResolution> createState() => _DeviceResolutionState();
}

class _DeviceResolutionState extends State<DeviceResolution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("managing 1x , 2x, 3x"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("1x"),
                Image.asset("assets/1x/home_ic.png"),
              ],
            ),
            Column(
              children: [
                Text("2x"),
                Image.asset("assets/2x/home_ic@2x.png"),
              ],
            ),
            Column(
              children: [
                Text("3x"),
                Image.asset("assets/3x/home_ic@3x.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
