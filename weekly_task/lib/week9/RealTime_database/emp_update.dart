import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateEmp extends StatefulWidget {
  String uUrl;
  String uId;
  String uName;
  String uDesig;
  String uMo;
  String uSalary;
  String uEmail;
  String uGender;

  UpdateEmp(
    this.uUrl,
    this.uId,
    this.uName,
    this.uDesig,
    this.uMo,
    this.uSalary,
    this.uEmail,
    this.uGender,
  );

  @override
  State<UpdateEmp> createState() => _UpdateEmpState(this.uUrl);
}

class _UpdateEmpState extends State<UpdateEmp> {
  @override
  void initState() {
    refDataInstance = FirebaseDatabase.instance.ref("employee");

    _UempId.text = widget.uId;
    _UempName.text = widget.uName;
    selectedValue = widget.uDesig;
    _UempMobileNo.text = widget.uMo;
    _UempSalary.text = widget.uSalary;
    _UempEmail.text = widget.uEmail;
    _gender = widget.uGender;
    selected = widget.uDesig.toString();

    // TODO: implement initState
    super.initState();
  }

  late DatabaseReference refDataInstance;

  String? proImg;
  _UpdateEmpState(this.upUrl);

  final _updateFormkey = GlobalKey<FormState>();

  TextEditingController _UempName = TextEditingController();
  TextEditingController _UempMobileNo = TextEditingController();
  TextEditingController _UempSalary = TextEditingController();
  TextEditingController _UempEmail = TextEditingController();
  TextEditingController _UempDesignation = TextEditingController();
  TextEditingController _UempId = TextEditingController();

  final empId = '';
  final empName = '';
  final empDesignation = '';
  final empMobile = '';
  final empSalary = '';
  final empEmail = '';
  final empGender = '';

  int dropdownEmploymentTypeValue = 0;
  List<String> designationItem = [
    'Flutter dev',
    'React Native dev',
    'Android dev ',
    'Backend dev',
  ];

  String? selectedValue;
  String? upUrl;
  File? _imgFile;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  String? selected;

  Widget Designation() {
    // selected = widget.uDesig.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DropdownButtonFormField2(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.teal),
            ),
            hintText: "Designation",
            prefixIcon: Icon(
              Icons.work,
              color: Colors.teal,
            ),
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          // isExpanded: true,

          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 30,
          buttonHeight: 60,
          // value: selected,
          buttonPadding: const EdgeInsets.only(right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          value: widget.uDesig.toString(),
          items: designationItem
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            print(value);
            if (value == null) {
              return 'Please select Designation.';
            }
            return null;
          },
          onChanged: (String? value) {
            setState(() {
              selected = value!;
            });
          },
          onSaved: (value) {
            selectedValue = value.toString();
          },
        ),
      ],
    );
  }

  String _gender = "male";

  Widget RadioButton() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            // contentPadding: EdgeInsets.only(left: 90),
            title: Text("male"),
            leading: Radio(
                activeColor: Colors.teal.shade300,
                value: "male",
                groupValue: _gender,
                onChanged: (String? value) {
                  setState(() {
                    _gender = value!;
                  });
                }),
          ),
        ),
        Expanded(
          child: ListTile(
            // contentPadding: EdgeInsets.only(left: 90),
            title: Text("female"),
            leading: Radio(
                activeColor: Colors.teal.shade300,
                value: "female",
                groupValue: _gender,
                onChanged: (String? value) {
                  setState(() {
                    _gender = value!;
                  });
                }),
          ),
        ),
      ],
    );
  }

  Widget NameField() {
    return TextFormField(
      autofocus: false,
      controller: _UempName,
      keyboardType: TextInputType.name,
      validator: (value) {
        print(value);
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Name must be 3 character");
        }
        return null;
      },
      onSaved: (value) {
        _UempName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.teal,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
      ),
    );
  }

  Widget IdField() {
    return TextFormField(
      autofocus: false,
      enabled: false,
      controller: _UempId,
      validator: (value) {
        print(value);
        if (value!.isEmpty) {
          return ("Name cannot be empty");
        }

        return null;
      },
      onSaved: (value) {
        _UempId.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          Icons.account_box,
          color: Colors.teal,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "emp Id",
      ),
    );
  }

  Widget MobileNoFeild() {
    return TextFormField(
      autofocus: false,
      maxLength: 10,
      controller: _UempMobileNo,
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return ("Mobile no cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Mobile must be 10 character");
        }
        return null;
      },
      onSaved: (value) {
        _UempMobileNo.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.teal,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mobile No.",
      ),
    );
  }

  Widget SalaryField() {
    return TextFormField(
      autofocus: false,
      controller: _UempSalary,

      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Salary no cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Salary must be 3 character");
        }
        return null;
      },
      onSaved: (value) {
        _UempSalary.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          Icons.currency_rupee,
          color: Colors.teal,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Salary",
      ),
    );
  }

  Widget EmailField() {
    return TextFormField(
      autofocus: false,
      controller: _UempEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter a email");
        }
        //reg exp for email validation
        if (!RegExp(r"^[a-z0-9+_.-]+@[a-z0-9.-]+\.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        _UempEmail.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.teal,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "email",
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            color: Colors.teal,
          ),
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

  Widget profilePic() {
    return _imgFile != null
        ? Column(
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                      image: FileImage(
                        File(_imgFile!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final imagepick =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _imgFile = File(imagepick!.path);
                  });
                },
                child: Text(
                  "Edit image",
                  style: TextStyle(color: Colors.teal, fontSize: 18),
                ),
              )
            ],
          )
        : upUrl != null
            ? Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: Container(
                      height: 120,
                      width: 120,
                      child: ClipOval(
                        child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl: upUrl!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Image.asset(
                                      "assets/images/avtar.png",
                                      fit: BoxFit.cover,
                                    ),
                            errorWidget: (context, url, error) => CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                )),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(60),
                        // image: DecorationImage(
                        //   image: NetworkImage(upUrl!),
                        //   fit: BoxFit.contain,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final imagepick =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _imgFile = File(imagepick!.path);
                      });
                    },
                    child: Text(
                      "Edit image",
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                          image: AssetImage("assets/images/avtar.png"),
                          fit: BoxFit.contain,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final imagepick =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _imgFile = File(imagepick!.path);
                      });
                    },
                    child: Text(
                      "Add image",
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  )
                ],
              );
  }

  Widget UpdateButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Colors.teal.shade300,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          var fileName = "id-${_UempId.text}";
          final destination = 'files/$fileName';
          // final Reference ref = FirebaseStorage.instance.ref().child(destination);
          // await ref.putFile(_imgFile!);
          if (_imgFile != null) {
            TaskSnapshot snapshot = await FirebaseStorage.instance
                .ref()
                .child(destination)
                .putFile(_imgFile!);

            final String downloadUrl = await snapshot.ref.getDownloadURL();


            if (_updateFormkey.currentState!.validate()) {

              showAlertDialog(context);
              await FirebaseAnalytics.instance.logEvent(
                  name: "id_${_UempId.text}_updated",
                  parameters: {
                    "update_successfully": "updated emp id - ${_UempId.text}"
                  });

              String? key = refDataInstance.child('employee').push().key;

              refDataInstance.child(fileName).update(
                {
                  'id': _UempId.text,
                  'name': _UempName.text,
                  'designation': selected,
                  'mobile': _UempMobileNo.text,
                  'salary': _UempSalary.text,
                  'email': _UempEmail.text,
                  'gender': _gender.toString(),
                  'url': downloadUrl
                },
              );
              Navigator.pop(context);
              setState(() {
                Navigator.pop(context);
              });
            }

          } else {
            if (_updateFormkey.currentState!.validate()) {

              showAlertDialog(context);
              await FirebaseAnalytics.instance.logEvent(
                  name: "id_${_UempId.text}_updated",
                  parameters: {
                    "update_successfully": "updated emp id - ${_UempId.text}"
                  });

              String? key = refDataInstance.child('employee').push().key;

              refDataInstance.child(fileName).update(
                {
                  'id': _UempId.text,
                  'name': _UempName.text,
                  'designation': selected,
                  'mobile': _UempMobileNo.text,
                  'salary': _UempSalary.text,
                  'email': _UempEmail.text,
                  'gender': _gender.toString(),
                  'url': upUrl
                },

              );
              Navigator.pop(context);
              setState(() {
                Navigator.pop(context);
              });
            };

          }
        },
        child: Text("update",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    _UempId.dispose();
    _UempEmail.dispose();
    _UempSalary.dispose();
    _UempMobileNo.dispose();
    _UempName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Employee",
          style: TextStyle(color: Colors.teal.shade200),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.teal.shade200,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _updateFormkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profilePic(),
                  IdField(),
                  SizedBox(
                    height: 15,
                  ),
                  NameField(),
                  SizedBox(
                    height: 15,
                  ),
                  Designation(),

                  SizedBox(
                    height: 15,
                  ),
                  MobileNoFeild(),
                  SizedBox(
                    height: 15,
                  ),
                  SalaryField(),
                  SizedBox(
                    height: 15,
                  ),
                  EmailField(),
                  SizedBox(
                    height: 15,
                  ),
                  RadioButton(),
                  SizedBox(
                    height: 15,
                  ),
                  UpdateButton(),
                  // StreamBuilder(
                  //     stream: refDataInstance.onValue,
                  //     builder: (context, snapshot) {
                  //       final List<Employee> list = [];
                  //
                  //       getUsers() async {
                  //         final snapshot = await FirebaseDatabase.instance.ref('employee').get();
                  //
                  //         final map = snapshot.value as Map<dynamic, dynamic>;
                  //
                  //         map.forEach((key, value) {
                  //           final user = Employee.fromMap(value);
                  //
                  //           list.add(user);
                  //         });
                  //       }
                  //   return ListView.builder(itemBuilder: (context, index) {
                  //     return ListTile(title: Text(list.length.),);
                  //   });
                  // })
                  // FirebaseAnimatedList(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context,DataSnapshot snapshot, animation, index) {
                  //     var responseData = snapshot.value;
                  //     //  String jsonsDataString = snapshot.value.toString(); // toString of Response's body is assigned to jsonDataString
                  //     // var _data = jsonDecode(jsonsDataString);
                  //     //  print(_data.toString());
                  //     //
                  //     final a=Map.from(json.decode(json.encode(snapshot.value)));
                  //     print(a["emp_mobile"]);
                  //     // final employees = json.decode(responseData.toString());
                  //     // var data = snapshot.value?[i[""];
                  //     // print(data.toString());
                  //     return GestureDetector(
                  //       onTap: () {
                  //
                  //       },
                  //       child: ListTile(
                  //         title: Text(a["emp_mobile"]),
                  //
                  //         trailing: IconButton(
                  //           icon: Icon(Icons.delete),
                  //           onPressed: () {
                  //             refDataInstance.child(snapshot.key!).remove();
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   query: refDataInstance,
                  //   shrinkWrap: true,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createDB() {
    refDataInstance.push().child(_UempId.text).set({
      'emp_name': _UempName,
      'emp_email': _UempEmail,
      'emp_mobile': _UempMobileNo,
      'emp_slary': _UempSalary,
      'emp_designation': selectedValue,
      'emp_gender': _gender
    }).asStream();
    refDataInstance.once().then((DatabaseEvent databaseEvent) {
      print(databaseEvent.snapshot.value.toString());
    });
  }
}
