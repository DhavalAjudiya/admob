// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:testadmob/images/database_helper.dart';
//
// class ima extends StatefulWidget {
//   const ima({Key? key}) : super(key: key);
//
//   @override
//   State<ima> createState() => _imaState();
// }
//
// class _imaState extends State<ima> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image"),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: DatabaseHelper.getQrScanner(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 snapshot.data?.docs.forEach(
//                   (element) {
//                     log("element -->${element.data()}");
//                   },
//                 );
//                 if (snapshot.hasData && snapshot.data != null) {
//                   return Expanded(
//                     child: ListView.separated(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         // snapshot.data!.docs.forEach((element) {
//                         //   log("element--->${element.data()}");
//                         // });
//
//                         return Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Stack(
//                                 children: [
//                                   Image.network(
//                                     snapshot.data?.docs[index]["im"],
//                                     width: 150,
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     right: 0,
//                                     child: CircleAvatar(
//                                       child: IconButton(
//                                         onPressed: () async {
//                                           try {
//                                             print(
//                                                 "imageId---11---->>>${snapshot.data?.docs[index]["im"]}");
//
//                                             var imageId = await ImageDownloader
//                                                 .downloadImage(snapshot
//                                                     .data?.docs[index]["im"]);
//                                             print("imageId---->>>$imageId");
//                                             if (imageId == null) {
//                                               return;
//                                             }
//                                             await GallerySaver.saveImage(
//                                                 imageId,
//                                                 albumName: "HDwallpaper");
//                                             // Below is a method of obtaining saved image information.
//                                           } on PlatformException catch (error) {
//                                             print(
//                                                 "PlatformException-----$error");
//                                           }
//                                         },
//                                         icon: Icon(Icons.download),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return const Divider(
//                           thickness: 1,
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return const Text("No data!");
//                 }
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
