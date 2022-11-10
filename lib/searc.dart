// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:testadmob/modal.dart';
//
// class Sear extends StatefulWidget {
//   const Sear({Key? key}) : super(key: key);
//
//   @override
//   State<Sear> createState() => _SearState();
// }
//
// class _SearState extends State<Sear> {
//   Future<Welcome?> fatchPostData(int select) async {
//     final url = "https://luso-american.org/api/get_agents.php";
//     // Map<String, dynamic> body = {"searchText": "wom", "pageIndex": select, "limit": 20, "returnQueryCount": true};
//     // Map<String, String> headers = {
//     //   "Content-Type": "application/json",
//     // };
//
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//       );
//       print("response  ==>>>${response.body}");
//       if (response.statusCode == 200) {
//         return Welcome.fromJson(jsonDecode(response.body));
//       } else {
//         return null;
//       }
//     } catch (e, st) {
//       print("error ==>>> ${e}===>>>${st}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   final passenger = data[index];
//                   return ListTile(
//                     title: Text("${passenger[0]}"),
//                     subtitle: Text("${data[index]}"),
//                     trailing: Text("${data[index]}"),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return const Divider(
//                     thickness: 2,
//                   );
//                 },
//                 itemCount: data.length),
//           ),
//         ],
//       ),
//     );
//   }
// }
