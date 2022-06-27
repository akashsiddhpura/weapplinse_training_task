import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Imagepicker extends StatefulWidget {
  const Imagepicker({Key? key}) : super(key: key);

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: const Text('Image Picker & Image Capture'),
        backgroundColor: Color.fromARGB(162, 0, 0, 0),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            image != null
                ? Container(
                    height: 180,
                    width: 180,
                    margin: EdgeInsets.only(top: 100, bottom: 70),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: Colors.black87, width: 2),
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                        image: FileImage(
                          File(image!.path),
                        ),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 180,
                    height: 180,
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                    margin: EdgeInsets.only(top: 100, bottom: 70),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 2),
                      color: Color.fromARGB(255, 184, 184, 184),
                      borderRadius: BorderRadius.circular(500),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),

            ElevatedButton(
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.camera);
                // Navigator.pop(context);
                setState(() {});
              },
              child: Container(
                height: 50,
                width: 169,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    Text(" Image from Camera")
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                // Navigator.pop(context);
                setState(() {});
              },
              child: Container(
                height: 50,
                width: 165,
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_album,
                      size: 30,
                    ),
                    Text(" Image from gallery")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
