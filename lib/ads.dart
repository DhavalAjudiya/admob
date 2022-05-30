import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  static bool isLoaded = false;
  const BannerAds({Key? key}) : super(key: key);
  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    // clearBannerAdData();
    // CustomBanners();
    adsFunction();
    _ad!.load();
  }

  // clearBannerAdData() {
  //   setState(() {
  //     AdConstants.url = '';
  //     AdConstants.id = 0;
  //     AdConstants.redirectionLink = '';
  //   });
  // }
  void adsFunction() {
    _ad = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: BannerAd.testAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            BannerAds.isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
      request: const AdRequest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(
        ad: _ad!,
      ),
      width: _ad!.size.width.toDouble(),
      height: _ad!.size.height.toDouble(),
      alignment: Alignment.center,
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return (!ConstantsData.status)
//         ? bannerAds.isLoaded
//             ? Container(
//                 child: AdWidget(
//                   ad: _ad,
//                 ),
//                 width: _ad.size.width.toDouble(),
//                 height: _ad.size.height.toDouble(),
//                 alignment: Alignment.center,
//               )
//             : SizedBox()
//         : CustomBanners();
//   }
// }
// class CustomBanners extends StatefulWidget {
//   @override
//   _CustomBannersState createState() => _CustomBannersState();
// }
//
// class _CustomBannersState extends State<CustomBanners> {
//   final _getPropertiesController = GetPropertiesController();
//
//   CustomBannerModel getCustomBannerModel = CustomBannerModel();
//
//   Future getCustomBanners() async {
//     getCustomBannerModel = await _getPropertiesController.getCustomBanners();
//     setState(() {
//       ConstantsData.url = getCustomBannerModel.url ?? 'null';
//       ConstantsData.id = getCustomBannerModel.id ?? '9';
//       ConstantsData.redirectionLink =
//           getCustomBannerModel.redirectionLink ?? 'null';
//       ConstantsData.status = getCustomBannerModel.status ?? false;
//     });
//
//     return getCustomBannerModel;
//   }
//
//   @override
//   void initState() {
//     getCustomBannerModel = null;
//     getCustomBanners();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return (ConstantsData.url.isNotEmpty)
//         ? GestureDetector(
//             onTap: () async {
//               _getPropertiesController.getClickEvent(ConstantsData.id);
//               String url = ConstantsData.redirectionLink;
//               if (await canLaunch(url))
//                 await launch(url);
//               else
//                 // can't launch url, there is some error
//                 throw "Could not launch $url";
//             },
//             child: Stack(alignment: Alignment.topLeft, children: [
//               Container(
//                 color: Colors.black12,
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 13.0,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                         ConstantsData.url,
//                         fit: BoxFit.fill,
//                         height: MediaQuery.of(context).size.height / 13.0,
//                         width: MediaQuery.of(context).size.width,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           )
//         : SizedBox();
//   }
// }
///
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:stock_info/ads/ad_constant.dart';
//
// class BannerAds extends StatefulWidget {
//   static bool isLoaded = false;
//
//   const BannerAds({Key? key}) : super(key: key);
//
//   @override
//   _BannerAdsState createState() => _BannerAdsState();
// }
//
// class _BannerAdsState extends State<BannerAds> {
//   BannerAd? _ad;
//
//   @override
//   void initState() {
//     super.initState();
//     clearBannerAdData();
//     // CustomBanners();
//     adsFunction();
//     _ad!.load();
//   }
//
//   clearBannerAdData() {
//     setState(() {
//       AdConstants.url = '';
//       AdConstants.id = 0;
//       AdConstants.redirectionLink = '';
//     });
//   }
//
//   void adsFunction() {
//     _ad = BannerAd(
//       size: AdSize.fullBanner,
//       adUnitId: AdConstants.bannerAdsId,
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           setState(() {
//             BannerAds.isLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           log('$BannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//       request: const AdRequest(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BannerAds.isLoaded
//         ? Container(
//             child: AdWidget(
//               ad: _ad!,
//             ),
//             width: _ad!.size.width.toDouble(),
//             height: _ad!.size.height.toDouble(),
//             alignment: Alignment.center,
//           )
//         : const SizedBox();
//   }
// }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return (!ConstantsData.status)
// //         ? bannerAds.isLoaded
// //             ? Container(
// //                 child: AdWidget(
// //                   ad: _ad,
// //                 ),
// //                 width: _ad.size.width.toDouble(),
// //                 height: _ad.size.height.toDouble(),
// //                 alignment: Alignment.center,
// //               )
// //             : SizedBox()
// //         : CustomBanners();
// //   }
// // }
//
// // class CustomBanners extends StatefulWidget {
// //   @override
// //   _CustomBannersState createState() => _CustomBannersState();
// // }
// //
// // class _CustomBannersState extends State<CustomBanners> {
// //   final _getPropertiesController = GetPropertiesController();
// //
// //   CustomBannerModel getCustomBannerModel = CustomBannerModel();
// //
// //   Future getCustomBanners() async {
// //     getCustomBannerModel = await _getPropertiesController.getCustomBanners();
// //     setState(() {
// //       ConstantsData.url = getCustomBannerModel.url ?? 'null';
// //       ConstantsData.id = getCustomBannerModel.id ?? '9';
// //       ConstantsData.redirectionLink =
// //           getCustomBannerModel.redirectionLink ?? 'null';
// //       ConstantsData.status = getCustomBannerModel.status ?? false;
// //     });
// //
// //     return getCustomBannerModel;
// //   }
// //
// //   @override
// //   void initState() {
// //     getCustomBannerModel = null;
// //     getCustomBanners();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return (ConstantsData.url.isNotEmpty)
// //         ? GestureDetector(
// //             onTap: () async {
// //               _getPropertiesController.getClickEvent(ConstantsData.id);
// //               String url = ConstantsData.redirectionLink;
// //               if (await canLaunch(url))
// //                 await launch(url);
// //               else
// //                 // can't launch url, there is some error
// //                 throw "Could not launch $url";
// //             },
// //             child: Stack(alignment: Alignment.topLeft, children: [
// //               Container(
// //                 color: Colors.black12,
// //                 width: MediaQuery.of(context).size.width,
// //                 height: MediaQuery.of(context).size.height / 13.0,
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Image.network(
// //                         ConstantsData.url,
// //                         fit: BoxFit.fill,
// //                         height: MediaQuery.of(context).size.height / 13.0,
// //                         width: MediaQuery.of(context).size.width,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ]),
// //           )
// //         : SizedBox();
// //   }
// // }
