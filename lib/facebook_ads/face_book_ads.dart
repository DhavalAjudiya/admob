import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/facebook_ads/faad_controller.dart';
import 'package:testadmob/facebook_ads/second_ad_page.dart';

class FaceBookAds extends StatelessWidget {
  FaceBookAds({Key? key}) : super(key: key);
  final FBAdsController fbAdsController = Get.put(FBAdsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Ads'),
      ),
      body: Column(
        children: [
          Align(
            alignment: const Alignment(0.5, 1.0),
            child: fbAdsController.currentAd,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              FacebookInterstitialAd.loadInterstitialAd(
                // placementId: "YOUR_PLACEMENT_ID",
                placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
                listener: (result, value) {
                  print(" Interstitial Ad --> $value");
                  if (result == InterstitialAdResult.LOADED) {
                    FacebookInterstitialAd.showInterstitialAd();
                  }
                },
              );
              Get.to(() => SecondAdPage());
            },
            child: const Text("InterstitialAd"),
          ),
          SizedBox(height: 20),
          Align(
            alignment: const Alignment(0.5, 1.0),
            child: fbAdsController.nativeBanner,
          ),
          ElevatedButton(
            onPressed: () {
              FacebookRewardedVideoAd.loadRewardedVideoAd(
                placementId: "755341135498106_755385832160303",
                listener: (result, value) {
                  print("Rewarded Ad: $result --> $value");
                  if (result == RewardedVideoAdResult.LOADED) {
                    FacebookRewardedVideoAd.showRewardedVideoAd();
                  }
                  if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
                    // if (result == RewardedVideoAdResult.VIDEO_CLOSED && (value == true || value["invalidated"] == true)) {
                    //   _isRewardedAdLoaded = false;
                    //   _loadRewardedVideoAd();
                    // }
                    Get.to(() => SecondAdPage());
                  }
                },
              );
            },
            child: const Text("RewardedVideoAd"),
          ),
          Align(
            alignment: const Alignment(0.5, 1.0),
            child: FacebookNativeAd(
              placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
              adType: NativeAdType.NATIVE_AD_VERTICAL,
              width: double.infinity,
              height: 300,
              bannerAdSize: NativeBannerAdSize.HEIGHT_100,
              backgroundColor: Colors.blue,
              titleColor: Colors.white,
              descriptionColor: Colors.white,
              buttonColor: Colors.deepPurple,
              buttonTitleColor: Colors.white,
              buttonBorderColor: Colors.white,
              listener: (result, value) {
                print("Native Ad: $result --> $value");
              },
              keepExpandedWhileLoading: true,
              expandAnimationDuraion: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
