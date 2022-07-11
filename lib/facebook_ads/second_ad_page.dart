import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/facebook_ads/faad_controller.dart';

class SecondAdPage extends StatelessWidget {
  SecondAdPage({Key? key}) : super(key: key);
  final FBAdsController fbAdsController = Get.find();

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
          SizedBox(height: 30),
          Align(
            alignment: const Alignment(0.5, 1.0),
            child: FacebookNativeAd(
              placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
              adType: NativeAdType.NATIVE_AD_HORIZONTAL,
              width: double.infinity,
              height: 300,
              bannerAdSize: NativeBannerAdSize.HEIGHT_120,
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
          SizedBox(height: 20),
          Align(
            alignment: const Alignment(0.5, 1.0),
            child: fbAdsController.nativeBanner,
          ),
        ],
      ),
    );
  }
}
