// import 'package:admob_flutter/admob_flutter.dart';
// import 'package:flutter/material.dart';
//
// import 'admobservice.dart';
//
// class AdMobFlutter extends StatefulWidget {
//   const AdMobFlutter({Key? key}) : super(key: key);
//
//   @override
//   _AdMobFlutterState createState() => _AdMobFlutterState();
// }
//
// class _AdMobFlutterState extends State<AdMobFlutter> {
//   final ams = AdMobService();
//
//   @override
//   void initState() {
//     Admob.initialize();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("AdMob Google"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Admob Ad",
//             style: TextStyle(fontSize: 30),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           AdmobBanner(
//             adUnitId: ams.getBannerAdId(),
//             adSize: AdmobBannerSize.SMART_BANNER(context),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "AdMob",
//             style: TextStyle(fontSize: 20),
//           )
//         ],
//       )),
//     );
//   }
// }
