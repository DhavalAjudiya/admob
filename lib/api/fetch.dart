import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testadmob/api/controller.dart';

class Screen extends StatefulWidget {
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            // Stack(
            //   clipBehavior: Clip.none,
            //   children: [
            //     Container(
            //       height: 110,
            //       width: 300,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.grey.shade600,
            //       ),
            //     ),
            //     Positioned(
            //       right: 13,
            //       bottom: -15,
            //       child: ClipPath(
            //         child: Container(
            //           width: 15,
            //           height: 15,
            //           color: Colors.grey.shade600,
            //         ),
            //         clipper: CustomClipPath(),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 400,
              width: 350,
              child: Obx(() => ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.data.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      ///20 data ///EVENT
                      ///pageIndex++  ==   listlength ˜/ 20; ??INDEX
                      ///API call
                      print(
                          "loading ==>> ${controller.scrollController.position.pixels}");
                      print(
                          "commentdata----1----> ${controller.data.first.comments?.first.id}");
                      print(
                          "commentdata----1----> ${controller.data.first.comments?.first.user?.name}");

                      print(
                          "commentdata----1----> ${controller.data.first.comments?.first.user?.email}");

                      print(
                          "commentdata----1----> ${controller.data.first.comments?.first.user?.geoCountry}");
                      // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      //   ///AFTER WIDGET BUILD
                      // });
                      final data = controller.data[index];
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data.geoCountry}"),
                                  Text(
                                      "${data.comments?.first.user?.geoCountry}"),
                                  Text("${data.title}"),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("${data.user?.username}"),
                                          Text("${data.user?.email}"),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text("${data.id}"),
                                          Text("${data.user?.id}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Image.network(
                                      "${data.user?.profile}",
                                      width: 80,
                                    ),
                                  ),
                                  Text("${data.user?.bio}",
                                      style: TextStyle(color: Colors.white)),
                                  Text("${data.user?.code}"),
                                  Text(
                                      "${DateFormat("EEE, d MMM").format(data.user?.emailVerifiedAt ?? DateTime.now())}"),
                                  Text(
                                      "${DateFormat("EEE, d MMM").format(data.user?.updatedAt ?? DateTime.now())}"),
                                  Text("${data.user?.private}"),
                                ],
                              ),
                            ),
                            margin: EdgeInsets.all(12),
                            color: Colors.red,
                            width: 360,
                            // height: 280,
                          ),
                          controller.data.value.length - 1 == index
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
