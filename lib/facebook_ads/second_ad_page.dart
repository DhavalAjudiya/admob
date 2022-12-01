// import 'package:facebook_audience_network/ad/ad_native.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:testadmob/facebook_ads/ads_type_class/facebook_native_ad.dart';
// import 'package:testadmob/facebook_ads/faad_controller.dart';
//
// class SecondAdPage extends StatelessWidget {
//   SecondAdPage({Key? key}) : super(key: key);
//   final FBAdsController fbAdsController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Facebook Ads'),
//       ),
//       body: Column(
//         children: [
//           Align(
//             alignment: const Alignment(0.5, 1.0),
//             child: fbAdsController.currentAd,
//           ),
//           SizedBox(height: 30),
//           const Align(
//             alignment: Alignment(0.5, 1.0),
//             child: FaceBookBannerAd(),
//           ),
//           SizedBox(height: 20),
//           Align(
//             alignment: const Alignment(0.5, 1.0),
//             child: fbAdsController.nativeBanner,
//           ),
//         ],
//       ),
//     );
//   }
// }
