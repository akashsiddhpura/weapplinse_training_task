import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreview extends StatelessWidget {

  // final List<File> fileList;
  final File imageFile;

  const ImagePreview({

    // required this.fileList,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image gallery'),
        elevation: 0,
        backgroundColor: Colors.black87,

      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.1,
              maxScale: 5,
              child: Image.file(
                imageFile,
                width: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
