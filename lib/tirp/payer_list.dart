import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/tirp/payer_controller.dart';

class PayerList extends StatelessWidget {
  PayerList({Key? key}) : super(key: key);
  final PayerController payerController = Get.put(PayerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: payerController.tripModal.length,
                itemBuilder: (BuildContext context, int index) {
                  // final current = _homeController.currentMatch
                  //     .value.matches?.notstarted?[index];
                  // final backTime = index == 0
                  //     ? chatTestController.chatModal[index].time
                  //     : chatTestController
                  //         .chatModal[index].time?[(index - 1)];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade500,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "${payerController.tripModal[index].place}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${payerController.tripModal[index].payer}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${payerController.tripModal[index].amount}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
