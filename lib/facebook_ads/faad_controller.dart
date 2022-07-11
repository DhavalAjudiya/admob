import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FBAdsController extends GetxController {
  FacebookBannerAd? currentAd;
  FacebookNativeAd? nativeBanner;
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  @override
  void onInit() {
    print(" ----- FBAdsController -----");

    FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true //default false
        );
    showBannerAd();
    print("----nativeBannerAd-----");

    nativeBannerAd();
    super.onInit();
  }

  ///banner Ad
  showBannerAd() {
    currentAd = FacebookBannerAd(
      // placementId: "YOUR_PLACEMENT_ID",
      // placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
      placementId: "755341135498106_755343738831179",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            print(" ERROR -->  $value");
            break;
          case BannerAdResult.LOADED:
            print(" LOADED -->  $value");
            break;
          case BannerAdResult.CLICKED:
            print(" LOADED -->  $value");
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print(" LOGGING_IMPRESSION -->  $value");
            break;
        }
      },
    );
  }

  ///nativeBanner Ad
  nativeBannerAd() {
    nativeBanner = FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      height: 200,
      bannerAdSize: NativeBannerAdSize.HEIGHT_120,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  InterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
        }

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          InterstitialAd();
        }
      },
    );
  }

  ///native Ad
  // nativeAd() {
  //   nativeBanner = FacebookNativeAd(
  //     placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
  //     adType: NativeAdType.NATIVE_AD_VERTICAL,
  //     width: double.infinity,
  //     height: 300,
  //     backgroundColor: Colors.blue,
  //     titleColor: Colors.white,
  //     descriptionColor: Colors.white,
  //     buttonColor: Colors.deepPurple,
  //     buttonTitleColor: Colors.white,
  //     buttonBorderColor: Colors.white,
  //     listener: (result, value) {
  //       print("Native Ad: $result --> $value");
  //     },
  //     keepExpandedWhileLoading: true,
  //     expandAnimationDuraion: 1000,
  //   );
  // }
}
