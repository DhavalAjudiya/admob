import 'package:flutter/material.dart';
import 'package:testadmob/realtime_database/custom_button.dart';
import 'package:testadmob/validation_utils.dart';

class ValueListion extends StatelessWidget {
  final ValueNotifier<bool> _test = ValueNotifier(true);
  final ValueNotifier<bool> isDisable = ValueNotifier(true);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime currentBackPressTime = DateTime(0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDF1F5),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ValueListenableBuilder(
                      valueListenable: _test,
                      builder: (context, bool value, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _test.value = !_test.value;
                              },
                              child: value ? const Text('Login With Mobile') : const Text("Login With Email"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            if (value)
                              Hero(
                                tag: "animateSignIn",
                                child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Enter Your Email",
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                    ),
                                    controller: emailController,
                                    onChanged: (String data) {
                                      _handleButtonDisable();
                                    },
                                    keyboardType: TextInputType.emailAddress),
                              )
                            else
                              Hero(
                                tag: "animateSignIn",
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    hintText: "Enter Your Number",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (String data) {
                                    _handleButtonDisable();
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: emailController,
                                ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                hintText: "Enter Your Password",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (String data) {
                                _handleButtonDisable();
                              },
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ValueListenableBuilder(
                                valueListenable: isDisable,
                                builder: (context, bool value, _) {
                                  return CustomButton(
                                    onTap: () {
                                      onSubmit(context);
                                    },
                                    change: value,
                                    text: "Submit",
                                  );
                                }),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) >
        const Duration(
          seconds: 2,
        )) {
      currentBackPressTime = now;
      // Fluttertoast.showToast(
      //   msg: "press back again to exit",
      //   backgroundColor: Colors.green,
      //   textColor: Colors.red,
      // );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void onSubmit(context) {
    FocusScope.of(context).unfocus();
    if ((_test.value ? emailController.text.isValidEmail() : emailController.text.isValidMobile()) && passwordController.text.isValidPassword()) {}
    print("emailcontroller---------${emailController.text}");
    print("passwordController---------${passwordController.text}");
  }

  void _handleButtonDisable() {
    isDisable.value =
        (emailController.text == "" || emailController.text.isEmpty) || (passwordController.text == "" || passwordController.text.isEmpty);
  }
}

// Future<bool> onWillPop() {
//   DateTime now = DateTime.now();
//   if (currentBackPressTime == null ||
//       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//     currentBackPressTime = now;
//     Fluttertoast.showToast(msg: exit_warning);
//     return Future.value(false);
//   }
//   return Future.value(true);
// }
