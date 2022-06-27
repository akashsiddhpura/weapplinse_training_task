import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DefaultCamera extends StatefulWidget {
  const DefaultCamera({Key? key}) : super(key: key);

  @override
  State<DefaultCamera> createState() => _DefaultCameraState();
}

class _DefaultCameraState extends State<DefaultCamera> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Default Camera"),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton( onPressed: () async {
        image = (await _picker.pickImage(source: ImageSource.camera));
        // Navigator.pop(context);
        setState(() {});
      } ,child: Icon(Icons.add),),
      body: Container(
        child:  Column(
          children: [

            image != null ?
            Expanded(
              child: InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.1,
                maxScale: 5,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(image!.path),
                      ),
                  ),
                ),
              ),
            ), ) : Container(),
          ],
        ),
      ),
    );
  }
}
