import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testadmob/anchored_adaptive_example.dart';
import 'package:testadmob/controller.dart';
import 'package:testadmob/googlead.dart';
import 'package:testadmob/inline_adaptive_example.dart';
import 'package:testadmob/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AContaroller aContaroller = Get.put(AContaroller());
  // final ams = AdMobService();
  int maxFailedLoadAttempts = 3;

  // BannerAd? _ad;
  // InterstitialAd? _interstitialAd;
  RewardedAd? rewardedAd;

  int num_of_attempt_load = 0;
  bool isloading = false;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  ///RewardedAd initerstitiald ads
  // void _createRewardedInterstitialAd() {
  //   RewardedInterstitialAd.load(
  //       adUnitId: Platform.isAndroid
  //           ? 'ca-app-pub-3940256099942544/5354046379'
  //           : 'ca-app-pub-3940256099942544/6978759866',
  //       request: const AdRequest(),
  //       rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
  //         onAdLoaded: (RewardedInterstitialAd ad) {
  //           print('$ad loaded.');
  //           _rewardedInterstitialAd = ad;
  //           _numRewardedInterstitialLoadAttempts = 0;
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('RewardedInterstitialAd failed to load: $error');
  //           _rewardedInterstitialAd = null;
  //           _numRewardedInterstitialLoadAttempts += 1;
  //           if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //             _createRewardedInterstitialAd();
  //           }
  //         },
  //       ));
  // }
  //
  // void _showRewardedInterstitialAd() {
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
  //       _createRewardedInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent:
  //         (RewardedInterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createRewardedInterstitialAd();
  //     },
  //   );
  //   _rewardedInterstitialAd!.setImmersiveMode(true);
  //   _rewardedInterstitialAd!.show(
  //       onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //     print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
  //   });
  //   _rewardedInterstitialAd = null;
  // }

  ///initerstitiald
  // void creatinter() {
  //   InterstitialAd.load(
  //     adUnitId: InterstitialAd.testAdUnitId,
  //     request: AdRequest(),
  //     adLoadCallback:
  //         InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
  //       _interstitialAd = ad;
  //       num_of_attempt_load = 0;
  //     }, onAdFailedToLoad: (LoadAdError error) {
  //       num_of_attempt_load + 1;
  //       _interstitialAd = null;
  //       if (num_of_attempt_load <= 2) {
  //         creatinter();
  //       }
  //     }),
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd!.setImmersiveMode(true);
  // }
  //
  // void showinter() {
  //   if (_interstitialAd == null) {
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdShowedFullScreenContent: (InterstitialAd iad) {
  //     print("iad onAdshowFullScreenConten");
  //   }, onAdDismissedFullScreenContent: (InterstitialAd iad) {
  //     print("ad Disposed");
  //     iad.dispose();
  //   }, onAdFailedToShowFullScreenContent:
  //           (InterstitialAd iad, AdError adError) {
  //     print("$iad onFailed $adError");
  //     iad.dispose();
  //     creatinter();
  //   });
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  ///rewaeredad
  // void rewaerdad() {
  //   print("-----------123------");
  //   RewardedAd.load(
  //     adUnitId: RewardedAd.testAdUnitId,
  //     request: AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (rad) {
  //         print("rewaerdad ad");
  //         rewardedAd = rad;
  //         setState(() {
  //           isloading = true;
  //         });
  //       },
  //       onAdFailedToLoad: (error) {
  //         print("rewaerdad error");
  //       },
  //     ),
  //   );
  //   rewardedAd?.setImmersiveMode(true);
  //   rewardedAd?.show(onUserEarnedReward: (ad, reward) {
  //     print("user watched complete ");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Admob.initialize();
    // _createRewardedInterstitialAd();
    // _ad = BannerAd(
    //   adUnitId: BannerAd.testAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.mediumRectangle,
    //   listener: BannerAdListener(
    //     onAdLoaded: (Ad ad) {
    //       print('$BannerAd loaded.');
    //     },
    //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //       print('$BannerAd failedToLoad: $error');
    //     },
    //     onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
    //     onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
    //   ),
    // );
    // _ad?.load();
    // creatinter();
    // showinter();
    // rewaerdad();
  }

  @override
  void dispose() {
    // _ad?.dispose();
    // _ad = null;
    super.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdasda"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // aContaroller.createRewardedInterstitialAd();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewAdMob();
            },
          ));
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // rewaerdad();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InlineAdaptiveExample();
                }));
              },
              child: const Text(
                "InlineAdaptiveExample",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                // rewaerdad();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AnchoredAdaptiveExample();
                }));
              },
              child: const Text(
                "AnchoredAdaptiveExample",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                // rewaerdad();
                aContaroller.createRewardedAd();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewAdMob();
                }));
              },
              child: const Text(
                "Google Ad",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                child: AdWidget(
                  ad: aContaroller.ad!,
                ),
                width: aContaroller.ad!.size.width.toDouble(),
                height: aContaroller.ad!.size.height.toDouble()),
            const SizedBox(
              height: 10,
            ),

            TextButton(
              // onLongPress: () {
              //   Navigator.push(context, MaterialPageRoute(
              //     builder: (context) {
              //       return NewAdMob();
              //     },
              //   ));
              // },
              onPressed: () {
                // showinter();
                aContaroller.createInterstitialAd();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewAdMob();
                  },
                ));
              },
              child: const Text(
                "AdMob",
                style: TextStyle(fontSize: 20),
              ),
            ),

            // AdmobBanner(
            //   adUnitId: ams.getBannerAdId(),
            //   adSize: AdmobBannerSize.SMART_BANNER(context),
            // ),
          ],
        ),
      ),
    );
  }
}
