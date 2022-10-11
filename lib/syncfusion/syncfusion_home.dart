import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/syncfusion/barcode_ganeret.dart';
import 'package:testadmob/syncfusion/map.dart';
import 'package:testadmob/syncfusion/pichart.dart';
import 'package:testadmob/syncfusion/range_slider.dart';
import 'package:testadmob/syncfusion/sing_pad.dart';

class SyncfusionHome extends StatelessWidget {
  const SyncfusionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          "Syncfusion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ButtonType(
                    onTap: () {
                      Get.to(HomePage2());
                    },
                    buttonName: "Pi Chart"),
                const SizedBox(
                  height: 10,
                ),
                _ButtonType(
                    onTap: () {
                      Get.to(BarcodeGenerate());
                    },
                    buttonName: "Barcode Generator"),
                const SizedBox(
                  height: 10,
                ),
                // _ButtonType(
                //     onTap: () {
                //       Get.to(SfMap());
                //     },
                //     buttonName: "SfMap"),
                // const SizedBox(
                //   height: 10,
                // ),
                _ButtonType(
                    onTap: () {
                      Get.to(SignaturePad());
                    },
                    buttonName: "SignaturePad"),
                const SizedBox(
                  height: 10,
                ),
                _ButtonType(
                    onTap: () {
                      Get.to(SfRangeSlider());
                    },
                    buttonName: "RangeSlider"),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ButtonType({
    final GestureTapCallback? onTap,
    final String? buttonName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Text(
            buttonName ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
