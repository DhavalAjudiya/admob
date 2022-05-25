import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewAdMob extends StatefulWidget {
  @override
  _NewAdMobState createState() => _NewAdMobState();
}

class _NewAdMobState extends State<NewAdMob> {
  /// fluidAd
  FluidAdManagerBannerAd? _fluidAd;
  double _width = 200.0;

  BannerAd? _bannerAd;
  NativeAd? _nativeAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: AdSize.largeBanner,
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

    _bannerAd?.load();
  }

  /// fluidAd
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _fluidAd = FluidAdManagerBannerAd(
      adUnitId: '/6499/example/APIDemo/Fluid',
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: AdManagerAdRequest(nonPersonalizedAds: true),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$_fluidAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$_fluidAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$_fluidAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$_fluidAd onAdClosed.'),
      ),
    )..load();
    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/2247696110'
          : 'ca-app-pub-3940256099942544/3986624511',
      request: AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          // setState(() {
          //   _nativeAdIsLoaded = true;
          // });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
    _fluidAd?.dispose();
    _nativeAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NativeAd? nativeAd = _nativeAd;

    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Mobile Ads'),
        actions: <Widget>[],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: 250,
          //   height: 350,
          //   child: AdWidget(ad: nativeAd!),
          // ),
          // Align(
          //   alignment: Alignment.center,
          //   child: FluidAdWidget(
          //     width: _width,
          //     ad: _fluidAd!,
          //   ),
          // ),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                alignment: Alignment.center,
                child: adWidget,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
              )),
        ],
      ),
    );
  }
}
