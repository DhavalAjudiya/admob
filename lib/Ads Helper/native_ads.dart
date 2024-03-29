import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testadmob/Ads%20Helper/ad_constant.dart';

class NativeAds extends StatefulWidget {
  const NativeAds({Key? key}) : super(key: key);

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  late NativeAd _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadNativeAd();
  }

  void loadNativeAd() {
    print('NativeAd ads--${AdConstants.bannerAdsId}');

    _ad = NativeAd(
        request: const AdRequest(),

        ///This is a test adUnitId make sure to change it
        adUnitId: 'ca-app-pub-3940256099942544/2247696110',
        // adUnitId: AdConstants.nativeAdsId,
        factoryId: 'listTile',
        listener: NativeAdListener(onAdLoaded: (ad) {
          print('NativeAd onAdLoaded--${AdConstants.bannerAdsId}');

          setState(() {
            isLoaded = true;
            // isLoaded = AdConstants.isShowNativeAds ;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('failed to load the ad ${error.message}, ${error.code}');
        }));

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            child: AdWidget(
              ad: _ad,
            ),
            alignment: Alignment.center,
            height: 90,
            // color: Colors.transparent,
            color: Colors.black12,
          )
        : SizedBox();
  }
}
