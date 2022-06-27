import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/week4/LazyModel.dart';
import 'package:http/http.dart' as http;

class InitPage1 extends StatefulWidget {
  const InitPage1({Key? key}) : super(key: key);

  @override
  State<InitPage1> createState() => _InitPage1State();
}

class _InitPage1State extends State<InitPage1> {
  LazyModel? abc;
  int page = 1;
  List photos = [];

  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Init page 1"),
        actions: [
          IconButton(
            onPressed: () async{
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>InitPage2()));
              getData();
            },
            icon: Icon(Icons.next_plan),
          )
        ],
      ),
      body: Container(
        child: abc != null
            ? GridView.builder(
                controller: _scrollController,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: photos.length + 1,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return CachedNetworkImage(
                    imageUrl: photos[index],
                    fit: BoxFit.cover,
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<LazyModel?> getData() async {
    // print(response.statusCode);

    try {
      var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=cars&per_page=13&page=" +
                page.toString()),
      );

      print(response.statusCode);
      List list = [];
      if (response.statusCode == 200) {
        abc = LazyModel.fromJson(jsonDecode(response.body));
        for (var i = 0; i < abc!.photos!.length; i++) {
          list.add(abc!.photos![i].src!.medium);
        }
        page++;
        photos.addAll(list);
        setState(() {});
        return abc;
      } else {
        LazyModel data = LazyModel();
        return data;
      }
    } catch (e) {
      LazyModel data = LazyModel();
      return data;
    }
  }
}

class InitPage2 extends StatelessWidget {
  const InitPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Init page 2"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back to page 1"),
        ),
      ),
    );
  }
}
