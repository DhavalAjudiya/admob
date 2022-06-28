import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:testadmob/images/bottombar/contant.dart';
import 'package:testadmob/images/database_helper.dart';

class God extends StatefulWidget {
  const God({Key? key}) : super(key: key);

  @override
  State<God> createState() => _GodState();
}

class _GodState extends State<God> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log("11111111112222222");

        Constant.bottomIndex.value = 0;
        log("selectedIndex : ${Constant.bottomIndex.value}");
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text("Animal Images"),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseHelper.getGodsImage(),
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
                                            "${snapshot.data!.docs[index]["im"]}",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 15,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueGrey,
                                        child: IconButton(
                                          onPressed: () async {
                                            print(
                                                "animal.change ---${snapshot.data!.docs[index]["im"]}");
                                            try {
                                              print(
                                                  "imageId---11---->>>${snapshot.data!.docs[index]["im"]}");

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
