import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testadmob/googlead.dart';
import 'package:testadmob/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final ams = AdMobService();

  BannerAd? _ad;
  InterstitialAd? _interstitialAd;
  RewardedAd? rewardedAd;

  int num_of_attempt_load = 0;
  bool isloading = false;

  ///initerstitiald ads
  void creatinter() {
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
          creatinter();
        }
      }),
    );
  }

  void showinter() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd iad) {
      print("iad onAdshowFullScreenConten");
    }, onAdDismissedFullScreenContent: (InterstitialAd iad) {
      print("ad Disposed");
      iad.dispose();
    }, onAdFailedToShowFullScreenContent:
            (InterstitialAd iad, AdError adError) {
      print("$iad onFailed $adError");
      iad.dispose();
      creatinter();
    });
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  ///rewaeredad
  void rewaerdad() {
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (rad) {
          print("rewaerdad ad");
          rewardedAd = rad;
          setState(() {
            isloading = true;
          });
        },
        onAdFailedToLoad: (error) {
          print("rewaerdad error");
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Admob.initialize();
    _ad = BannerAd(
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
    _ad?.load();
    creatinter();
    showinter();
    rewaerdad();
    showOpenAd();
  }

  @override
  void dispose() {
    _ad?.dispose();
    _ad = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdasda"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showOpenAd();
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
                rewardedAd?.show(onUserEarnedReward: (ad, reward) {
                  print("user watched complete ");
                });
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
                  ad: _ad!,
                ),
                width: _ad!.size.width.toDouble(),
                height: _ad!.size.height.toDouble()),
            const SizedBox(
              height: 10,
            ),

            TextButton(
              onLongPress: () {
                creatinter();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewAdMob();
                  },
                ));
              },
              onPressed: () {
                showinter();
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
