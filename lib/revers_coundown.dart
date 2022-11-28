// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ReversCounDown extends StatefulWidget {
//   const ReversCounDown({Key? key}) : super(key: key);
//
//   @override
//   State<ReversCounDown> createState() => _ReversCounDownState();
// }
//
// class _ReversCounDownState extends State<ReversCounDown> {
//   int dateFormat(int time, String format) {
//     DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
//     String result = '';
//     final DateFormat formatter = DateFormat(format);
//     result = formatter.format(date);
//     DateTime parseDate = DateFormat(format).parse(result);
//     return parseDate.millisecondsSinceEpoch;
//   }
//
//   Timer? _timer;
//   int _start = 10;
//
//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           RaisedButton(
//             onPressed: () {
//               startTimer();
//             },
//             child: const Text("start"),
//           ),
//           const SizedBox(height: 10),
//           Text("$_start"),
//           const SizedBox(height: 10),
//           Center(
//             child: TweenAnimationBuilder<Duration>(
//               duration: const Duration(milliseconds: 1668452400545454545),
//               tween: Tween(
//                 begin: const Duration(milliseconds: 1668452400545454545),
//                 end: Duration.zero,
//               ),
//               onEnd: () {
//                 print('Timer ended');
//               },
//               builder: (
//                 BuildContext context,
//                 Duration value,
//                 Widget? child,
//               ) {
//                 final hour = value.inHours % 12;
//                 final minutes = value.inMinutes % 60;
//                 final seconds = value.inSeconds % 60;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Text(
//                     '$hour:$minutes:$seconds',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

//String value = "";

class _UserListPageState extends State<UserListPage> {
  // final SplitifyControler splitifyController = Get.find()..getOnBoardingDetail();
  var data;

  // List dvalue = [];
  String dvalue = "abv";

  @override
  Widget build(BuildContext context) {
    data = Get.arguments;
    List data2 = ["uname", "sdd", "dd", "name", "asdasd"];
    log("data${data.toString()}");
    log("data2${data2}");

    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    String dropdownvalue = 'Item 1';
    const List<String> list = <String>["uname", "sdd", "dd", "name", "asdasd"];
    String dropdownValue = list.first;

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          // DropdownButton(
          //   value: dvalue,
          //   items: data2
          //       .map(
          //         (Stringe) => DropdownMenuItem(
          //           value: e,
          //           child: Text(
          //             e,
          //             // style: TextStyle(fontSize: SizeUtils.fSize_16(), color: Colors.black),
          //           ),
          //         ),
          //       )
          //       .toList(),
          //   onChanged: (String? value) {
          //     setState(
          //       () {
          //         print("value${value}");
          //         dvalue = value  ;
          //       },
          //     );
          //     // data2 = e as List;
          //   },
          // ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }

  _commonContainer({
    double? width,
    double? height,
    final Color? color,
    final String? text,
    final Gradient? gradient,
  }) {
    return Container(
      width: width,
      alignment: Alignment.center,
      height: height,
      child: Text(text!),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }
}
