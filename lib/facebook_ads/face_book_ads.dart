// import 'package:facebook_audience_network/ad/ad_interstitial.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:testadmob/facebook_ads/ads_type_class/facebook_native_ad.dart';
// import 'package:testadmob/facebook_ads/faad_controller.dart';
// import 'package:testadmob/facebook_ads/second_ad_page.dart';
//
// class FaceBookAds extends StatelessWidget {
//   FaceBookAds({Key? key}) : super(key: key);
//   final FBAdsController fbAdsController = Get.put(FBAdsController());
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
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               fbAdsController.interstitialAdView(
//                 listener: (result, value) {
//                   if (result == InterstitialAdResult.LOADED) {
//                     FacebookInterstitialAd.showInterstitialAd().then(
//                       (value) => Get.to(() => SecondAdPage()),
//                     );
//                   }
//
//                   if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
//                     // InterstitialAd();
//                   }
//                 },
//               );
//             },
//             child: const Text("InterstitialAd"),
//           ),
//           const SizedBox(height: 20),
//           Align(
//             alignment: const Alignment(0.5, 1.0),
//             child: fbAdsController.nativeBanner,
//           ),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     // FacebookRewardedVideoAd.loadRewardedVideoAd(
//           //     //   placementId: "755341135498106_755385832160303",
//           //     //   listener: (result, value) {
//           //     //     print("Rewarded Ad: $result --> $value");
//           //     //     if (result == RewardedVideoAdResult.LOADED) {
//           //     //       FacebookRewardedVideoAd.showRewardedVideoAd();
//           //     //     }
//           //     //     if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
//           //     //       // if (result == RewardedVideoAdResult.VIDEO_CLOSED && (value == true || value["invalidated"] == true)) {
//           //     //       //   _isRewardedAdLoaded = false;
//           //     //       //   _loadRewardedVideoAd();
//           //     //       // }
//           //     //       Get.to(() => SecondAdPage());
//           //     //     }
//           //     //   },
//           //     // );
//           //   },
//           //   child: const Text("RewardedVideoAd"),
//           // ),
//           const Align(
//             alignment: Alignment(0.5, 1.0),
//             child: FaceBookBannerAd(),
//           ),
//         ],
//       ),
//     );
//   }
// }
