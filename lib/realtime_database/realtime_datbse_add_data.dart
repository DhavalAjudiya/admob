import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testadmob/realtime_database/custom_button.dart';
import 'package:testadmob/realtime_database/get_data_realtime.dart';
import 'package:testadmob/realtime_database/textfield.dart';

class RealTimeData extends StatelessWidget {
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController schoolFriendController = TextEditingController();
  final TextEditingController schoolFriendSirNameController =
      TextEditingController();
  final TextEditingController collegeFriendController = TextEditingController();
  final TextEditingController collegeFriendSirNameController =
      TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Time Data Base"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _test,
                  builder: (context, bool value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _test.value = !_test.value;
                          },
                          child: value
                              ? const Text('Login With Mobile')
                              : const Text("Login With Email"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (value)
                          Hero(
                            tag: "animateSignIn",
                            child: CustomTextField(
                              hintText: "Enter Your Email",
                              controller: emailController,
                              onChanged: (String data) {
                                _handleButtonDisable();
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          )
                        else
                          Hero(
                            tag: "animateSignIn",
                            child: CustomTextField(
                              hintText: "Enter Your PhoneNumber",
                              controller: phoneController,
                              onChanged: (String data) {
                                _handleButtonDisable();
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your Password",
                          controller: passwordController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your Hobby",
                          controller: hobbyController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your school FriedName",
                          controller: schoolFriendController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your school FriedSirName",
                          controller: schoolFriendSirNameController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your College FriedName",
                          controller: collegeFriendController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Enter Your College FriedSirName",
                          controller: collegeFriendSirNameController,
                          onChanged: (String data) {
                            _handleButtonDisable();
                          },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: isDisable,
                          builder: (context, bool value, _) {
                            return Column(
                              children: [
                                CustomButton(
                                  onTap: () {
                                    onSubmit(context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => GetData(),
                                      ),
                                    );
                                    setData();
                                  },
                                  change: value,
                                  text: "Submit",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  onTap: () {
                                    onSubmit(context);
                                    updateData();
                                    getData();
                                  },
                                  change: value,
                                  text: "Update",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  onTap: () {
                                    deleteData();
                                  },
                                  change: value,
                                  text: "Delete",
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getData() {
    databaseReference.once();
    // databaseReference.once().then((DataSnapshot snapshot) {
    //   print("Data------>${snapshot.value} \n ");
    // });
  }

  setData() {
    databaseReference.child("UserData/user").set(
      {
        "email": emailController.text,
        "number": phoneController.text,
        "password": passwordController.text,
        "hobby": hobbyController.text,
        "friendMap": {
          'clgfriend': [
            {
              "name": collegeFriendController.text,
              "sirName": collegeFriendSirNameController.text
            }
          ],
          'schoolFriend': [
            {
              "name": schoolFriendController.text,
              "sirName": schoolFriendSirNameController.text,
            }
          ]
        },
      },
    );
    print("set data ");
  }

  updateData() {
    databaseReference.child("UserData/user").update(
      {
        "email": emailController.text,
        "number": phoneController.text,
        "password": passwordController.text,
        "hobby": hobbyController.text,
        "friendMap": {
          'clgfriend': [
            {
              "name": collegeFriendController.text,
              "sirName": collegeFriendSirNameController.text
            }
          ],
          'schoolFriend': [
            {
              "name": schoolFriendController.text,
              "sirName": schoolFriendSirNameController.text,
            }
          ]
        },
      },
    );
    print("Updated data ");
    // getData();
  }

  deleteData() {
    databaseReference.child("UserData").remove();
  }

  void onSubmit(context) {
    FocusScope.of(context).unfocus();
    if ((_test.value
            ? emailController.text.isNotEmpty
            : emailController.text.isNotEmpty) &&
        passwordController.text.isNotEmpty) {}
    print("emailcontroller---------${emailController.text}");
    print("passwordController---------${passwordController.text}");
  }

  void _handleButtonDisable() {
    isDisable.value =
        (emailController.text == "" || emailController.text.isEmpty) ||
            (passwordController.text == "" || passwordController.text.isEmpty);
  }
}
