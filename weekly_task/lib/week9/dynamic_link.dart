// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekly_task/homepage/Homepage.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';
import 'package:weekly_task/week9/Firebase_Auth/login_home/login_home.dart';

class Dynamic_Link extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Dynamic_LinkState();
}

class _Dynamic_LinkState extends State<Dynamic_Link> {
  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String _testString = "Long press to copy";

  final String DynamicLink = 'https://weapdemo.page.link/weapDemo';
  final String Link = 'https://reactnativefirebase.page.link/bFkn';

  @override
  void initState() {
    super.initState();
    this._initDynamicLinks();
  }

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData dynamicLink) async {
      final Uri? deepLink = dynamicLink.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, '/loginPage');
      }
    }, onError: (e) async {
      Navigator.pushNamed(context, '/firstpage');
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://weapdemo.page.link',
      // longDynamicLink: Uri.parse(
      //   'https://weapdemo.page.link/weapDemo',
      // ),
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.weekly_task',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.weekly_task.ios',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Links Example'),
          backgroundColor: Colors.black87,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: !_isCreatingLink
                        ? () => _createDynamicLink(false)
                        : null,
                    child: const Text('Get Long Link'),
                  ),
                  ElevatedButton(
                    onPressed: !_isCreatingLink
                        ? () => _createDynamicLink(true)
                        : null,
                    child: const Text('Get Short Link'),
                  ),
                  // SelectableText(_linkMessage!,style: TextStyle(color: Colors.black),),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: _linkMessage));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied Link!')),
                        );
                      },
                      child: Text(
                        _linkMessage ?? '',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Text(_linkMessage == null ? '' : _testString),
                  _linkMessage == null
                      ? Container()
                      : IconButton(
                    color: Colors.grey,
                          onPressed: () {
                            Share.share(_linkMessage.toString());
                          },
                          icon: Icon(Icons.share))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//adb shell setprop debug.firebase.analytics.app com.example.weekly_task
