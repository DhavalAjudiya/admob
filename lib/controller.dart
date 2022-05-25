import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AContaroller extends GetxController {
  BannerAd? ad;

  ///InterstitialAd
  InterstitialAd? _interstitialAd;
  int num_of_attempt_load = 0;

  ///RewardedAd
  RewardedAd? rewardedAd;
  bool isloading = false;

  ///RewardedAd InterstitialAd ads

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  // double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);
  //
  // AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
  //     _adWidth.truncate());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bannerAd();
    createInterstitialAd();
    // createRewardedAd();
    // createRewardedInterstitialAd();
  }

  ///bannerAd
  void bannerAd() {
    ad = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    ad?.load();
  }

  ///InterstitialAd
  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        num_of_attempt_load + 1;
        _interstitialAd = null;
        if (num_of_attempt_load <= 2) {
          createInterstitialAd();
        }
      }),
    );
    _interstitialAd!.show();
    _interstitialAd!.setImmersiveMode(true);
  }

  ///RewardedAd
  void createRewardedAd() {
    print("-----------123------");
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (rad) {
          print("rewaerdad ad");
          rewardedAd = rad;

          isloading = true;
        },
        onAdFailedToLoad: (error) {
          print("rewaerdad error");
        },
      ),
    );
    rewardedAd?.setImmersiveMode(true);
    rewardedAd?.show(onUserEarnedReward: (ad, reward) {
      print("user watched complete ");
    });
  }

  ///RewardedAd InterstitialAd ads
  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
            }
          },
        ));
    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
  }

  // void showRewardedInterstitialAd() {
  //   if (_rewardedInterstitialAd == null) {
  //     print('Warning: attempt to show rewarded interstitial before loaded.');
  //     return;
  //   }
  //   _rewardedInterstitialAd!.fullScreenContentCallback =
  //       FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
  //         print('$ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       createRewardedInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent:
  //         (RewardedInterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       createRewardedInterstitialAd();
  //     },
  //   );
  //   _rewardedInterstitialAd!.setImmersiveMode(true);
  //   _rewardedInterstitialAd!.show(
  //       onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //     print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
  //   });
  //   _rewardedInterstitialAd = null;
  // }
}
