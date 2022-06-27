import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileOperationsScreen extends StatefulWidget {
  FileOperationsScreen() : super();

  @override
  _FileOperationsScreenState createState() => _FileOperationsScreenState();
}

class _FileOperationsScreenState extends State<FileOperationsScreen> {
  String fileContents = "No Data";
  final name_controller = TextEditingController();
  final msg_controller = TextEditingController();
  List listFiles = List.empty(growable: true);
  var _scaffold_key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.getFiles().then((value) => {
          setState(() {
            listFiles = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold_key,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white24,
        title: Text(
          "File Operations",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: new InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "File Name"),
              controller: name_controller,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              decoration: new InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "File data"),
              controller: msg_controller,
            ),
            SizedBox(height: 10,),
            RaisedButton(
              child: Text("Save File",style: TextStyle(color: Colors.white),),
              color:  Color(0xEE1C1B1B),
              onPressed: () {
                if (name_controller.text.length <= 0) {
                  _scaffold_key.currentState!.showSnackBar(
                      SnackBar(content: Text("Please Enter File name")));
                  return;
                }
                if (msg_controller.text.length <= 10) {
                  _scaffold_key.currentState!.showSnackBar(
                      SnackBar(content: Text("Please Enter File Data")));
                  return;
                }
                FileUtils.saveToFile(
                        "${name_controller.text}.txt", msg_controller.text)
                    .then(
                  (value) => {
                    FileUtils.getFiles().then(
                      (value) => {
                        setState(
                          () {
                            listFiles = value;
                          },
                        )
                      },
                    )
                  },
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start  ,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "List Of Files",
                      //bbh
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 15,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listFiles.length,
                itemBuilder: (context, index) {
                  String dt = '';
                  String path = listFiles[index].path;
                  String file_name = path.substring(path.lastIndexOf("/") + 1);
                  FileUtils.readFromFile(file_name).then(
                    (contents) {
                      setState(() {
                        dt = contents;
                      });
                    },
                  );
                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(file_name),
                      onTap: () {
                        FileUtils.readFromFile(file_name).then(
                          (contents) {
                            _scaffold_key.currentState!.showBottomSheet(
                              (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xEE1C1B1B),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            contents,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileUtils {
  static String folderName = "MyFiles";
  static Future<String> get getFilePath async {
    final directory = await getExternalStorageDirectory();
    final Directory _appDocDirFolder =
        Directory('${directory!.path}/${folderName}/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  static Future<List> getFiles() async {
    final directory = await getExternalStorageDirectory();
    final Directory _appDocDirFolder =
        Directory('${directory!.path}/${folderName}/');
    print(_appDocDirFolder);

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.listSync();
    }
    return List.empty(growable: true);
  }

  static Future<File> getFile(String name) async {
    final path = await getFilePath;

    return File('$path/$name');
  }

  static Future<File> saveToFile(String name, data) async {
    print(name);
    final file = await getFile(name);
    return file.writeAsString(data);
  }

  static Future<String> readFromFile(name) async {
    try {
      final file = await getFile(name);
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory? _appDocDir = await getExternalStorageDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir!.path}/$folderName/');
//vgvggvg
    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
}
