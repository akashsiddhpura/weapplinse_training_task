import 'dart:convert';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:weekly_task/week2/demoslider.dart';
import 'package:weekly_task/week3/API/add_data.dart';
import 'package:weekly_task/week3/API/get_user_list_model.dart';
import 'package:weekly_task/week3/API/update_api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiCalling extends StatefulWidget {
  const ApiCalling({Key? key}) : super(key: key);

  @override
  State<ApiCalling> createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> with WidgetsBindingObserver {
  var statedata;
  final ApiProvider apiService = ApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("add data");
    setState(() {
      getUserListModel = getApi();
    });
  }

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

  // deleteDialog(BuildContext context) {
  //   setState(() {
  //     getUserListModel = getApi();
  //   });
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API calling"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: getUserListModel != null && getUserListModel?.data?.length != 0
            ? ListView.builder(

                // shrinkWrap: true,
                itemCount: getUserListModel!.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title:
                          Text(getUserListModel!.data![index].name.toString()),
                      subtitle: Text(
                          "${getUserListModel!.data![index].email.toString()} "),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                var edit = await Navigator.push(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateApi(
                                        getUserListModel!.data![index].userId
                                            .toString(),
                                        getUserListModel!.data![index].name
                                            .toString(),
                                        getUserListModel!.data![index].email
                                            .toString(),
                                        getUserListModel!
                                            .data![index].profilePic
                                            .toString());
                                  },
                                ));

                                setState(() {
                                  getUserListModel = getApi();
                                });
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                showAlertDialog(context);
                                print(getUserListModel!.data![index].userId);
                                // getUserListModel =
                                //     apiService.deleteData(Data(userId: index));
                                var datade = {
                                  "user_id": getUserListModel!
                                      .data![index].userId
                                      .toString(),
                                  "_method": "DELETE"
                                };
                                String res =
                                    await apiService.deleteData(datade);

                                if (res == "sucess") {
                                  getUserListModel!.data!.removeAt(index);
                                  setState(() {});
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "post deleted");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "post not deleted");
                                }

                                // setState(() {
                                //   //   // getUserListModel = getApi();
                                // });
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                      leading: ClipOval(
                        child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl:
                                "${getUserListModel?.data?[index].profilePic}",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Image.asset(
                                      "assets/images/star.png",
                                      fit: BoxFit.cover,
                                    ),
                            errorWidget: (context, url, error) => CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                )),
                      ));
                })
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var getdata = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));

          setState(() {
            getUserListModel = getApi();
          });
        },
        child: Icon(Icons.add),
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

class ApiProvider {
  Future<GetUserListModel?> getData() async {
    // print(response.statusCode);

    try {
      var response = await http.get(
          Uri.parse("http://192.168.1.42/Practical_Api/api/get_user_list"),
          headers: {
            "Token":
                "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
          });

      print(response.statusCode);

      if (response.statusCode == 200) {
        GetUserListModel abc =
            GetUserListModel.fromJson(jsonDecode(response.body));
        return abc;
      } else {
        GetUserListModel data = GetUserListModel(
            data: null,
            message: jsonDecode(response.body)["message"],
            status: false,
            statusCode: 0);
        return data;
      }
    } catch (e) {
      GetUserListModel data = GetUserListModel(
          data: null, message: "exception", status: false, statusCode: 0);
      return data;
    }
  }

  Future<String> addData(String name, String email, String imgpath) async {
    try {
      var response = await http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.1.42/Practical_Api/api/add_user"),
      );
      var headers = {
        "Token":
            "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
      };

      // response.files.add(await http.MultipartFile.fromPath('profile_pic', img));
      response.headers.addAll(headers);

      response.fields['name'] = name;
      response.fields['email'] = email;
      response.files
          .add(await http.MultipartFile.fromPath('profile_pic', imgpath));

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

  deleteData(data) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.1.42/Practical_Api/api/delete_user"),
          body: data,
          headers: {
            "Token":
                "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
          });

      print(response.statusCode);

      if (response.statusCode == 200) {
        return "sucess";
      } else {
        return "error";
      }
    } catch (e) {
      return "data";
    }
  }

  // Future<String?> uploadImage(filepath, url) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse("http://192.168.1.14/Practical_Api/api/add_user"));

  //   var res = await request.send();
  // }
}
