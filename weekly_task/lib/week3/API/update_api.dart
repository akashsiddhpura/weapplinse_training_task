import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weekly_task/week3/API/apicalling.dart';
import 'package:image_picker/image_picker.dart';

class UpdateApi extends StatefulWidget {
  String userId;
  String name;
  String email;
  String profile_pic;

  UpdateApi(this.userId, this.name, this.email, this.profile_pic);

  @override
  State<UpdateApi> createState() => _UpdateApiState();
}

class _UpdateApiState extends State<UpdateApi> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool isLoading = true;
  // final ApiProvider updatedata = ApiProvider();

  var uid = '';

  final _formkey = GlobalKey<FormState>();
  TextEditingController _namecon = TextEditingController();
  TextEditingController _emailcon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecon.text = widget.name;
    _emailcon.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image != null
                    ? Container(
                        height: 100,
                        width: 100,
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
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 100, bottom: 30),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87, width: 2),
                          color: Color.fromARGB(255, 184, 184, 184),
                          borderRadius: BorderRadius.circular(500),
                          image: DecorationImage(
                            image: NetworkImage(widget.profile_pic),
                            fit: BoxFit.cover,
                          ),
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
                    final imagepick =
                        await _picker.pickImage(source: ImageSource.gallery);
                    // Navigator.pop(context);
                    setState(() {
                      image = imagepick;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 76,
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_album,
                          size: 30,
                        ),
                        Text("upload")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _namecon,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailcon,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    String res =
                        await updateData( _namecon.text,_emailcon.text,);
                    Navigator.of(context).pop();
                    setState(() {});
                    // }
                    print(_namecon);
                    print(_emailcon);
                    print(image!.path);
                    print(widget.userId);
                  },
                  color: Colors.black87,
                  child: Text(
                    "submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> updateData(String name, String email) async {
    try {
      var response = await http.put(
        Uri.parse("http://192.168.1.42/Practical_Api/api/edit_user_details"),
        body: {
          'user_id': widget.userId,
          'name': name,
          'email': email,
        },
        headers: {
          'Token':
              'dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc'
        },
      );

      // var res = await response.send();

      print(response.statusCode);

      if (response.statusCode == 200) {
        if (image != null) {
          Map<String, String> bodydata = Map<String, String>();
          bodydata['user_id'] = widget.userId;
          await changeImage(image!.path, bodydata);
        }
        return "sucess";
      } else {
        return "error";
      }
    } catch (e) {
      return "data";
    }
  }

  changeImage(String path, Map<String, String> bodydata) async {
    try {
      var response = await http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.1.42/Practical_Api/api/change_profile_pic"),
      );
      var headers = {
        "Token":
            "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
      };

      response.headers.addAll(headers);
      response.fields.addAll(bodydata);

      response.files
          .add(await http.MultipartFile.fromPath('profile_pic', path));

      var res = await response.send();

      print(res.statusCode);

      if (res.statusCode == 200) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return "data";
    }
  }
}
