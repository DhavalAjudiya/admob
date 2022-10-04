import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testadmob/realtime_database/modal.dart';
import 'package:testadmob/realtime_database/textfield.dart';

import 'custom_button.dart';

class GetData extends StatefulWidget {
  GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  final databaseReference = FirebaseDatabase.instance.ref().child("UserData").child("user");

  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _schoolFriendController = TextEditingController();
  final TextEditingController _schoolFriendSirNameController = TextEditingController();
  final TextEditingController _collegeFriendController = TextEditingController();
  final TextEditingController _collegeFriendSirNameController = TextEditingController();

  List dataList = [];
  Map itemData = {};
  User? user;

  @override
  void initState() {
    print('77777777');
    super.initState();
    fun();
    // databaseReference.once().then((value) {
    //   print('77777777$value');
    //   value.snapshot.children.forEach((element) {
    //     print('element=====>${element.value}');
    //     final data = User.fromJson(element);
    //   });
    //
    // });
  }

  fun() async {
    print("resultList[i]===>");
    List<User> list = [];
    DatabaseEvent snap = await databaseReference.once();
    print("resultList[i]===>${snap.snapshot.children}");
    List<dynamic> resultList = snap.snapshot.children.toList();
    var abc = <String, dynamic>{};
    for (var i = 0; i < resultList.length; i++) {
      DataSnapshot snapshot = resultList[i];
      abc[snapshot.key ?? ''] = snapshot.value;
    }
    var map = abc;
    print("snapshot.value[i]===>$map");
    itemData = map;
    User user = User.fromJson(itemData);
    print("userToJson ${user.toJson()}");
    setState(() {});
    print("resultList[i]===leng>${list.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                child: Table(
                  textDirection: TextDirection.ltr,
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  // border: TableBorder.all(width: 1.5, color: Colors.red),
                  children: [
                    table(
                        data: "email",
                        text: "${user?.email}",
                        editOnPress: () {
                          _showDialog(context);
                        },
                        deleteOnPress: () {
                          deleteData();
                        }),
                    table(
                      data: "number",
                      text: '${user?.email}',
                      editOnPress: () {
                        _showDialog(context);
                      },
                    ),
                    table(
                      data: "hobby",
                      text: "${user?.hobby}",
                      editOnPress: () {
                        _showDialog(context);
                      },
                    ),
                    table(
                      data: "Collage Friends",
                      text: "${user?.friendMap?.clgfriend?.first.name} ${user?.friendMap?.clgfriend?.first.sirName}  ",
                      editOnPress: () {
                        _showDialog(context);
                      },
                    ),
                    table(
                      data: "School Friends",
                      text: "${user?.friendMap?.schoolFriend?.first.name} ${user?.friendMap?.schoolFriend?.first.sirName}  ",
                      editOnPress: () {
                        _showDialog(context);
                      },
                    ),
                  ],
                ),
                // child: FirebaseAnimatedList(
                //   query: databaseReference,
                //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
                //       Animation<double> animation, int index) {
                //     print("resultList[i]===> ${snapshot.children.toList()}");
                //     // List<User> list = [];
                //     // List<dynamic> resultList = snapshot.children.toList();
                //     // Map map = {};
                //     // for (var i = 0; i < resultList.length; i++) {
                //     //   DataSnapshot snapshot = resultList[i];
                //     //   print(
                //     //       "snapshot.value[i]===${snapshot.key}:>${snapshot.value}");
                //     //   map[snapshot.key] = snapshot.value;
                //     //   print("snapshot.value[i]===>$map");
                //     // }
                //     // list.add(User.fromJson(json.encode(map)));
                //     // print("resultList[i]===leng>${list.length}");
                //     //
                //     return Table(
                //       textDirection: TextDirection.ltr,
                //       defaultVerticalAlignment:
                //           TableCellVerticalAlignment.middle,
                //       // border: TableBorder.all(width: 1.5, color: Colors.red),
                //       children: [
                //         table(
                //             data: "email",
                //             text: "${itemData['email']}",
                //             editOnPress: () {
                //               _showDialog(context);
                //             },
                //             deleteOnPress: () {
                //               deleteData();
                //             }),
                //         table(
                //           data: "number",
                //           text: itemData["number"] ?? '',
                //           editOnPress: () {
                //             _showDialog(context);
                //           },
                //         ),
                //         table(
                //           data: "hobby",
                //           text: "${itemData["hobby"]}",
                //           editOnPress: () {
                //             _showDialog(context);
                //           },
                //         ),
                //         // table(
                //         //   data: "Collage Friends",
                //         //   text:
                //         //       "${itemData.friendMap?.clgfriend![index].name} ${itemData.friendMap?.clgfriend![index].sirName}  ",
                //         //   editOnPress: () {
                //         //     _showDialog(context);
                //         //   },
                //         // ),
                //         // table(
                //         //   data: "School Friends",
                //         //   text:
                //         //       "${itemData.friendMap?.schoolFriend![index].name} ${itemData.friendMap?.schoolFriend![index].sirName}  ",
                //         //   editOnPress: () {
                //         //     _showDialog(context);
                //         //   },
                //         // ),
                //       ],
                //     );
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow table({
    required String data,
    required String text,
    final VoidCallback? editOnPress,
    final VoidCallback? deleteOnPress,
  }) {
    return TableRow(
      children: [
        Text(data),
        Text(text),
        const Spacer(),
        InkWell(
          onTap: editOnPress,
          child: const Icon(
            Icons.edit,
          ),
        ),
        InkWell(
          onTap: deleteOnPress,
          child: const Icon(
            Icons.delete,
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Colors.grey.shade200,
            title: CustomTextField(
                controller: _emailController,
                onChanged: (String data) {
                  // _handleButtonDisable();
                },
                hintText: "Enter Your Email"),
            actions: [
              ValueListenableBuilder(
                valueListenable: isDisable,
                builder: (context, bool value, _) {
                  return Column(
                    children: [
                      CustomButton(
                        onTap: () {
                          updateData();
                          Navigator.pop(context);
                        },
                        change: value,
                        text: "Update",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  updateData() {
    databaseReference.child("UserData/user").update({
      "email": _emailController.text,
      "number": _phoneController.text,
      "password": _passwordController.text,
      "hobby": _hobbyController.text,
      "friendMap": {
        'clgfriend': [
          {"name": _collegeFriendController.text, "sirName": _collegeFriendSirNameController.text}
        ],
        'schoolFriend': [
          {
            "name": _schoolFriendController.text,
            "sirName": _schoolFriendSirNameController.text,
          }
        ],
      },
    });
    print("Updated data ");
    // getData();
  }

  deleteData() {
    databaseReference.child("UserData/email").remove();
  }
}
