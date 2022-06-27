
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class CustomDynamic extends StatefulWidget {

  @override
  _CustomDynamicState createState() => _CustomDynamicState();
}

class _CustomDynamicState extends State<CustomDynamic> with WidgetsBindingObserver {

  String _shortUrl = '';
  final String DynamicLink = 'https://weapdemo.page.link/weapDemo';
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    this._initDynamicLinks();
  }

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLink) async {
          final Uri? deepLink = dynamicLink.link;

          if (deepLink != null) {
            Navigator.pushNamed(context, '/loginPage');
          }
        },
        onError: (e) async {
          Navigator.pushNamed(context, '/firstpage');
        }
    );

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://weapdemo.page.link',
      link: Uri.parse(DynamicLink),
      androidParameters: AndroidParameters(
        packageName: 'com.example.weekly_task',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.weekly_task.ios',
        minimumVersion: '1',
        appStoreId: '123',
      ),
    );

    final ShortDynamicLink shortDynamicLink = await dynamicLinks.buildShortLink(parameters);
    final Uri shortUrl = shortDynamicLink.shortUrl;

    setState(() {
      _shortUrl = shortUrl.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('custom dynamic'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: const Text('Create Link'),
              onPressed: () {
                _createDynamicLink();
              },
            ),
            SelectableText(_shortUrl,style: TextStyle(color: Colors.black),),
          ],
        ),
      ),
    );
  }
}