import 'package:flutter/material.dart';

var videoList = [
  {
    'name' : 'video 1',
    'video_url' : 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    'thumb_url': 'assets/images/coffee.jpg'
  },
  {
    'name' : 'video 1',
    'video_url' : 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
    'thumb_url': 'assets/images/pizza.jpg'
  },
  {
    'name' : 'video 1',
    'video_url' : 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
    'thumb_url': 'assets/images/cake.jpg'
  }
];

class Video_Player extends StatefulWidget {
  const Video_Player({Key? key}) : super(key: key);

  @override
  State<Video_Player> createState() => _Video_PlayerState();
}

class _Video_PlayerState extends State<Video_Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: videoList.map((e) => GestureDetector(onTap: null,child: Image.network(e['thumb_url']!),)).toList(),
      ),
    );
  }
}
