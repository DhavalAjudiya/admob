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
  bool change = false;
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
                          snapshot.data!.docs.forEach((element) {
                            log("element--->${element.data()}");
                          });

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
                                        child: IconButton(
                                          onPressed: () async {
                                            try {
                                              print(
                                                  "imageId---11---->>>${snapshot.data?.docs[index]["im"]}");

                                              var imageId =
                                                  await ImageDownloader
                                                      .downloadImage(snapshot
                                                          .data
                                                          ?.docs[index]["im"]);
                                              print("imageId---->>>$imageId");
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
                                          icon: Icon(Icons.download),
                                        ),
                                        backgroundColor: Colors.blueGrey,
                                      ),
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
                    return const Text("No data!");
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
