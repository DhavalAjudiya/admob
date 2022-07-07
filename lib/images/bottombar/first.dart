import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:testadmob/images/database_helper.dart';

class Nature extends StatefulWidget {
  const Nature({Key? key}) : super(key: key);

  @override
  State<Nature> createState() => _NatureState();
}

class _NatureState extends State<Nature> {
  final CollectionReference<Map<String, dynamic>> _firebaseFirestore =
      FirebaseFirestore.instance.collection("nature");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text("Nature Images"),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseHelper.getNatureImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  snapshot.data?.docs.forEach(
                    (element) {
                      log("element -->${element.data()}");
                    },
                  );
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.5,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // snapshot.data!.docs.forEach((element) {
                          //   log("element--->${element.data()}");
                          // });
                          String docId = snapshot.data!.docs[index].id;
                          log("docId--->$docId");

                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      height: 250,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshot.data?.docs[index]["im"],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 15,
                                      child: CircleAvatar(
                                        child: GestureDetector(
                                          onTap: () async {
                                            await DatabaseHelper.updateNature(
                                                ch: true, docId: docId);

                                            try {
                                              var imageId =
                                                  await ImageDownloader
                                                      .downloadImage(snapshot
                                                          .data
                                                          ?.docs[index]["im"]);

                                              if (imageId == null) {
                                                return;
                                              }
                                              await GallerySaver.saveImage(
                                                  imageId,
                                                  albumName: "HDwallpaper");
                                              // Below is a method of obtaining saved image information.
                                            } on PlatformException catch (error) {
                                              print(
                                                  "PlatformException-----$error");
                                            }
                                          },
                                          child: snapshot.data?.docs[index]
                                                      ["ch"] ==
                                                  true
                                              ? Icon(Icons.done)
                                              : Icon(Icons.download),
                                        ),
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 15,
                                      child: snapshot.data?.docs[index]["ch"] ==
                                              true
                                          ? CircleAvatar(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await DatabaseHelper
                                                      .deleteNature(
                                                          docId: docId);
                                                },
                                                child: Icon((Icons.delete)),
                                              ),
                                              backgroundColor: Colors.blueGrey,
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: const Text("No data!"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
