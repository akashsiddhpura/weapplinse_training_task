import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weekly_task/week9/RealTime_database/empData_model.dart';

enum Gender { male, female }

class AddEmp extends StatefulWidget {
  const AddEmp({Key? key}) : super(key: key);

  @override
  State<AddEmp> createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {
  late DatabaseReference refDataInstance;
  final _formkey = GlobalKey<FormState>();

  TextEditingController _empName = TextEditingController();
  TextEditingController _empMobileNo = TextEditingController();
  TextEditingController _empSalary = TextEditingController();
  TextEditingController _empEmail = TextEditingController();
  TextEditingController _empDesignation = TextEditingController();
  TextEditingController _empId = TextEditingController();

  final empId = '';
  final empName = '';
  final empDesignation = '';
  final empMobile = '';
  final empSalary = '';
  final empEmail = '';
  final empGender = '';

  File? _imgFile;
  final ImagePicker _picker = ImagePicker();

  int dropdownEmploymentTypeValue = 0;
  List<String> designationItem = [
    'Flutter dev',
    'React Native dev',
    'Android dev ',
    'Backend dev',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  String selected = '';

  Widget Designation() {
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

          buttonPadding: const EdgeInsets.only(right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
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
      controller: _empName,
      keyboardType: TextInputType.name,
      validator: (value) {
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
        _empName.text = value!;
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
      controller: _empId,
      maxLength: 10,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be empty");
        }

        return null;
      },
      onSaved: (value) {
        _empId.text = value!;
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
      controller: _empMobileNo,
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
        _empMobileNo.text = value!;
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
      controller: _empSalary,
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
        _empSalary.text = value!;
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
      controller: _empEmail,
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
        _empEmail.text = value!;
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

  Widget AddButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Colors.teal.shade300,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formkey.currentState!.validate() && _imgFile != null) {
            await FirebaseAnalytics.instance.logEvent(name: "employee_added", parameters: {"add_status": "employee added successfully"});
            showAlertDialog(context);
            var fileName = "id-${_empId.text}";
            final destination = 'files/$fileName';
            // final Reference ref = FirebaseStorage.instance.ref().child(destination);
            // await ref.putFile(_imgFile!);
            TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child(destination).putFile(_imgFile!);

              final String downloadUrl = await snapshot.ref.getDownloadURL();
            String? key = refDataInstance.child('employee').push().key;

            await refDataInstance.child(fileName).set(
              {
                'id': _empId.text,
                'name': _empName.text,
                'designation': selected,
                'mobile': _empMobileNo.text,
                'salary': _empSalary.text,
                'email': _empEmail.text,
                'gender': _gender.toString(),
                'url' : downloadUrl
              },
            );
            // await ref.child("profile_img/profile").putFile(_image!);

            Navigator.pop(context);
            setState(() {
              Navigator.pop(context);
            });
          }
          else if (_imgFile == null) {
            Fluttertoast.showToast(msg: "Please upload image");
          }
        },
        child: Text("Add Employee",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
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
        : Column(
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
                    _imgFile =  File(imagepick!.path);
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

  @override
  void initState() {
    refDataInstance = FirebaseDatabase.instance.ref("employee");

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _empId.dispose();
    _empEmail.dispose();
    _empSalary.dispose();
    _empMobileNo.dispose();
    _empName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee",style: TextStyle(color: Colors.teal.shade200),),
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
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
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
                    AddButton(),
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
      ),
    );
  }

  createDB() {
    refDataInstance.push().child(_empId.text).set({
      'emp_name': _empName,
      'emp_email': _empEmail,
      'emp_mobile': _empMobileNo,
      'emp_slary': _empSalary,
      'emp_designation': selectedValue,
      'emp_gender': _gender
    }).asStream();
    refDataInstance.once().then((DatabaseEvent databaseEvent) {
      print(databaseEvent.snapshot.value.toString());
    });
  }
}
