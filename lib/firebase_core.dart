// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class Core extends StatefulWidget {
//   const Core({Key? key}) : super(key: key);
//
//   @override
//   _CoreState createState() => _CoreState();
// }
//
// class _CoreState extends State<Core> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Core"),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("imgdata")
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.active) {
//                       return ListView(
//                         children: snapshot.data!.docs.map((docs) {
//                           return ListTile(
//                             leading: CircleAvatar(
//                               backgroundImage: NetworkImage(docs["img"]),
//                             ),
//                             title: Text(docs["name"]),
//                           );
//                         }).toList(),
//                       );
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
