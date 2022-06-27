import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class Sharing extends StatefulWidget {
  const Sharing({Key? key}) : super(key: key);

  @override
  State<Sharing> createState() => _SharingState();
}

class _SharingState extends State<Sharing> {
  TextEditingController shareText = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  Color? btncolor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sharing"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    image != null
                        ? Container(
                            height: 200,
                            width: 200,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              border:
                                  Border.all(color: Colors.black87, width: 2),
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
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.person,
                              size: 70,
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 30),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black87, width: 2),
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
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        controller: shareText,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          label: Text("Enter Message"),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final imagepick = await _picker.pickImage(
                            source: ImageSource.gallery);
                        // Navigator.pop(context);
                        setState(() {
                          image = imagepick;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 110,
                        child: Row(
                          children: [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            Text("Pick Image")
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // final image =await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (image == null) {
                          Fluttertoast.showToast(msg: "Please upload image");
                        }
                        ;
                        await Share.shareFiles([image!.path],
                            text: shareText.text);
                      },
                      child: Text("Share image"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (shareText.value.text.isNotEmpty) {
                          await Share.share(shareText.text);
                        } else {
                          Fluttertoast.showToast(msg: "Please enter message");
                        }
                      },
                      child: Text("Share Text"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buidButton(
                        icon: FontAwesomeIcons.facebookSquare,
                        color: Colors.blue,
                        onClicked: () => onButtonTap(ShareSocial.facebook)),
                    buidButton(
                        icon: FontAwesomeIcons.whatsappSquare,
                        color: Colors.green,
                        onClicked: () => onButtonTap(ShareSocial.whatsapp)),
                    buidButton(
                        icon: FontAwesomeIcons.twitterSquare,
                        color: Colors.blueAccent,
                        onClicked: () => onButtonTap(ShareSocial.twitter)),
                    buidButton(
                        icon: FontAwesomeIcons.instagramSquare,
                        color: Colors.red,
                        onClicked: () => onButtonTap(ShareSocial.instagram))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buidButton(
          {required IconData icon,
          Color? color,
          required VoidCallback onClicked}) =>
      InkWell(
        child: Container(
          width: 64,
          height: 64,
          child: Center(
            child: FaIcon(
              icon,
              color: color,
              size: 40,
            ),
          ),
        ),
        onTap: onClicked,
      );

  Future<void> onButtonTap(ShareSocial share) async {
    String msg =
        'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
    String url =
        'https://images.unsplash.com/photo-1610878180933-123728745d22?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case ShareSocial.facebook:
        response = await flutterShareMe.shareToFacebook(

          url: url,
          msg: shareText.text,
        );
        break;
      // case Share.messenger:
      //   response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
      //   break;
      case ShareSocial.twitter:
        if (shareText.text.isNotEmpty) {
          response = await flutterShareMe.shareToTwitter(msg: shareText.text);
        } else {
          Fluttertoast.showToast(msg: "Please enter message");
        }
        break;
      case ShareSocial.whatsapp:
        if (image != null) {
          response = await flutterShareMe.shareToWhatsApp(
              imagePath: image!.path, msg: shareText.text);
        } else {
          Fluttertoast.showToast(msg: "Please upload image");
        }
        break;

      case ShareSocial.instagram:
        if (image != null) {
          response =
              await flutterShareMe.shareToInstagram(filePath: image!.path);
        } else {
          Fluttertoast.showToast(msg: "Please upload image");
        }
        break;
    }
    debugPrint(response);
  }
}

enum ShareSocial { facebook, whatsapp, twitter, instagram }
