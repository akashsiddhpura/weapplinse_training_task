import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weekly_task/week4/LazyModel.dart';

class LazyLoading extends StatefulWidget {
  const LazyLoading({Key? key}) : super(key: key);

  @override
  State<LazyLoading> createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {
  LazyModel? abc;
  int page = 1;
  List photos = [];

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    getData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy Loading "),
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
}
