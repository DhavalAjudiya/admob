import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testadmob/syncfusion/barcode_ganeret.dart';
import 'package:testadmob/syncfusion/pichart.dart';
import 'package:testadmob/syncfusion/range_slider.dart';
import 'package:testadmob/syncfusion/sing_pad.dart';

class SyncfusionHome extends StatefulWidget {
  const SyncfusionHome({Key? key}) : super(key: key);

  @override
  State<SyncfusionHome> createState() => _SyncfusionHomeState();
}

class _SyncfusionHomeState extends State<SyncfusionHome> {
  TextEditingController numberController = TextEditingController();
  String amount = "";
  double tip = 0;

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      amount = val;
                      if (amount.isEmpty) {
                        tip = 0.0;
                      }
                      setState(() {}); // amount = numberController.text;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black26,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: const Text(
                          "15%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          tip = double.parse(amount) * 15 / 100;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          "18%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          tip = double.parse(amount) * 18 / 100;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          "20%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          tip = double.parse(amount) * 20 / 100;
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          "22%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          tip = double.parse(amount) * 22 / 100;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  "tip : $tip",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "amount : $amount",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
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
