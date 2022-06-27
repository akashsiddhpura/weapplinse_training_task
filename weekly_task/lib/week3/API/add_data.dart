import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weekly_task/week2/demoslider.dart';
import 'package:weekly_task/week3/API/apicalling.dart';
import 'package:weekly_task/week3/API/get_user_list_model.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool isLoading = true;

  final ApiProvider adddata = ApiProvider();
  final _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD user"),
        backgroundColor: Colors.black87,
      ),
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
                        child: Icon(
                          Icons.person,
                          size: 70,
                        ),
                        margin: EdgeInsets.only(top: 100, bottom: 30),
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
                    final imagepick =
                        await _picker.pickImage(source: ImageSource.gallery);
                    // Navigator.pop(context);
                    setState(() {
                      image = imagepick;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 75,
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("please enter name");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("name must be 3 character");
                    }
                    return null;
                  },
                  // onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,

                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty ) {
                      return 'Please enter email';
                    }

                    return null;
                  },
                  // onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {

                    final isValid = _formkey.currentState!.validate();
                    if (image != null && isValid) {

                      showAlertDialog(context);
                      String res = await adddata.addData(_nameController.text,
                          _emailController.text, image!.path);

                      // if (res == "sucess") {
                      //   setState(() {});
                      //   Navigator.pop(context);
                      // }
                      // res == "sucess"
                      //     ? Fluttertoast.showToast(msg: "post created")
                      //     : Fluttertoast.showToast(msg: "post not created");

                      // if (res == "success") {
                      //   setState(() {});
                      //   Navigator.of(context).pop();

                      // }
                      res == "success"
                          ? Fluttertoast.showToast(msg: "post created")
                          : Fluttertoast.showToast(msg: "post not created");

                      Navigator.of(context).pop();

                      setState(() {
                        Navigator.of(context).pop();
                        // _emailController.clear();
                        // _nameController.clear();
                        // image == null;
                      });

                    } else if (image == null) {
                      Fluttertoast.showToast(msg: "Please upload image");
                    }

                    // }
                    print(_nameController);
                    print(_emailController);
                    print(image!.path);
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

  GetUserListModel? getUserListModel;
  getApi() {
    ApiProvider().getData().then((value) {
      getUserListModel = value;
      setState(() {});
    }).catchError((onError) {
      print(">> $onError");
      //  stop loader
    });
  }
}
