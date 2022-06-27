import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Install extends StatelessWidget {
  const Install({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Webview example",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black87,
      ),
      body: WebView(
        initialUrl: "https://docs.flutter.dev/get-started/install/windows",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
