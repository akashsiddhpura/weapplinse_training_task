import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weekly_task/week3/SQLite/database/database_helper.dart';
import 'package:weekly_task/week3/SQLite/model/data_model.dart';

class SQLHomePage extends StatefulWidget {
  const SQLHomePage({Key? key}) : super(key: key);

  @override
  State<SQLHomePage> createState() => _SQLHomePageState();
}

class _SQLHomePageState extends State<SQLHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descripController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  final _db = DatabaseHelper();

  bool isTitleValid(String title) => title.length > 5;
  bool isDescValid(String? desc) => desc!.length > 10;

  List<Note> _notes = <Note>[];

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? sqlImage;
  String? upImage;
  bool isLoading = true;
// File _f=File();
// String im=base64Encode(_f.readAsBytesSync())
//   var x=base64Decode(im);
  _noteSaveUpdate({Note? noteS}) async {
    String _title = _titleController.text;
    String _description = _descripController.text;
    String _image = base64Encode(sqlImage!.readAsBytesSync());

    // if(sqlImage != null){
    //   _image = base64Encode(sqlImage!.readAsBytesSync());
    // }

    if (noteS == null) {
      //Saving ...
      Note note = Note(
        _title,
        _description,
        _image,
      );
      int result = await _db.saveNote(note);
    } else {
      //Updating ...
      noteS.title = _title;
      noteS.description = _description;
      noteS.image = _image;
      // noteS.data = DateTime.now().toString             ();

      int result = await _db.updateNote(noteS);
    }

    _titleController.clear();
    _descripController.clear();
    sqlImage == null;

    _recoverNotes();
  }

  _removeNote(int id) async {
    await _db.removeNote(id);
    _recoverNotes();
  }

  _recoverNotes() async {
    List notesRecovered = await _db.recoverNote();
    List<Note>? tempList = <Note>[];

    for (var item in notesRecovered) {
      Note note = Note.fromMap(item);
      tempList.add(note);
    }

    setState(() {
      _notes = tempList!;
    });
    tempList = null;
  }

  _showNoteScreen({Note? note}) {
    String textUpdate = '';
    String titleUpdate = '';

    if (note == null) {
      //saving ...
      _titleController.text = '';
      _descripController.text = '';
      sqlImage = null;
      textUpdate = 'Save';
      titleUpdate = 'Add';
    } else {
      //updating ...
      _titleController.text = note.title!;
      _descripController.text = note.description!;
      upImage = note.image!;
      textUpdate = 'Update';
      titleUpdate = 'Update';
    }

    void _save() {
      Navigator.pop(context);
      _noteSaveUpdate(noteS: note);
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('$titleUpdate Note'),
              content: Form(
                key: formGlobalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        sqlImage != null
                            ? Container(
                                height: 50,
                                width: 50,
                                // margin: EdgeInsetseInsets.only(top: 100, bottom: 70),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  border: Border.all(
                                      color: Colors.black87, width: 2),
                                  borderRadius: BorderRadius.circular(500),
                                  image: DecorationImage(
                                    image: FileImage(
                                      sqlImage!,
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
                            : upImage != null
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    // margin: EdgeInsetseInsets.only(top: 100, bottom: 70),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      border: Border.all(
                                          color: Colors.black87, width: 2),
                                      borderRadius: BorderRadius.circular(500),
                                      image: DecorationImage(
                                        image:
                                            MemoryImage(base64Decode(upImage!)),
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
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    // margin: EdgeInsets.only(top: 100, bottom: 70),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87, width: 2),
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
                        IconButton(
                            onPressed: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50);
                              // Navigator.pop(context);
                              // Future.delayed(Duration(milliseconds: 500), () async {
                              //
                              //   setState(() {
                              //     image;
                              //   });
                              // });

                              setState(() {
                                sqlImage = File(image!.path);
                              });
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                    TextFormField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Title', hintText: 'Type a title ...'),
                      validator: (title) {
                        if (isTitleValid(title!))
                          return null;
                        else
                          return 'Title must be 5+ character';
                      },
                    ),
                    TextFormField(
                      validator: (desc) {
                        if (isDescValid(desc))
                          return null;
                        else
                          return 'Description must be 10o+ character';
                      },
                      controller: _descripController,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Type a description...'),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   _titleController.text.isEmpty
                    //       ? _validate = true
                    //       : _validate = false;
                    // });

                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   _titleController.text.isEmpty
                    //       ? _validate = true
                    //       : _validate = false;
                    // });
                    if (formGlobalKey.currentState!.validate() &&
                        sqlImage != null) {
                      formGlobalKey.currentState!.save();
                      _save();
                      // use the title provided here
                    } else if (sqlImage == null) {
                      Fluttertoast.showToast(msg: "Please upload image");
                    }
                  },
                  child: Text(textUpdate),
                ),
              ],
            );
          },
        );
      },
    ).then((value) => sqlImage = null);
  }

  // _dateFormat(String date) {
  //   initializeDateFormatting('en_US');
  //   var formatter = DateFormat('MMM/d/y');

  //   DateTime dateConverted = DateTime.parse(date);
  //   String dateFormated = formatter.format(dateConverted);

  //   return dateFormated;
  // }

  @override
  void initState() {
    _recoverNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite DB'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final note = _notes[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: MemoryImage(base64Decode(note.image!)),
                      radius: 30,
                    ),
                    title: Text(note.title!),
                    subtitle: Text(' ${note.description}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      //Edit
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child:
                              Icon(Icons.edit, color: Colors.purple.shade900),
                        ),
                        onTap: () {
                          print(note.image!);
                          _showNoteScreen(note: note);
                        },
                      ),

                      //Remove
                      GestureDetector(
                        child:
                            const Icon(Icons.delete_forever, color: Colors.red),
                        onTap: () {
                          // _removeNote(note.id!);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Are you sure to delete"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("cancel")),
                                      TextButton(
                                          onPressed: () {
                                            _removeNote(note.id!);

                                            Navigator.pop(context);
                                          },
                                          child: Text("delete"))
                                    ],
                                  ));
                        },
                      ),
                    ]),
                  ),
                );
              },
              itemCount: _notes.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple.shade900,
        child: const Icon(Icons.add),
        onPressed: () {
          sqlImage = null;
          _showNoteScreen();
        },
      ),
    );
  }
}
