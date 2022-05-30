import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testadmob/ads.dart';
import 'package:testadmob/anchored_adaptive_example.dart';
import 'package:testadmob/controller.dart';
import 'package:testadmob/googlead.dart';
import 'package:testadmob/inline_adaptive_example.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AContaroller aContaroller = Get.put(AContaroller());

  int maxFailedLoadAttempts = 3;

  RewardedAd? rewardedAd;

  int num_of_attempt_load = 0;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdasda"),
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return NewAdMob();
                // }));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NewAdMob()));
              },
              child: const Text(
                "Google Ad",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BannerAds(),
            // Container(
            //     // child: ,
            //     child: AdWidget(
            //       ad: aContaroller.ad!,
            //     ),
            //     width: aContaroller.ad!.size.width.toDouble(),
            //     height: aContaroller.ad!.size.height.toDouble()),
            const SizedBox(
              height: 10,
            ),

            TextButton(
              onLongPress: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewAdMob();
                  },
                ));
              },
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
