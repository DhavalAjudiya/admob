import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/tirp/app_textfield.dart';
import 'package:testadmob/tirp/button.dart';
import 'package:testadmob/tirp/payer_list.dart';
import 'package:testadmob/tirp/shared_preference.dart';
import 'package:testadmob/tirp/trip_controller.dart';
import 'package:testadmob/tirp/trip_modal.dart';

class TripPage extends StatelessWidget {
  TripPage({Key? key}) : super(key: key);
  final TripController tripController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                keyboardType: TextInputType.streetAddress,
                controller: tripController.placeNameController,
              ),
              const SizedBox(height: 10),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                keyboardType: TextInputType.name,
                controller: tripController.payerNameController,
              ),
              const SizedBox(height: 10),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                keyboardType: TextInputType.number,
                controller: tripController.amountController,
              ),
              SizedBox(height: Get.height * 0.30),
              button(
                onTap: () {
                  final TripModal _tripModal = TripModal();
                  _tripModal.place = tripController.placeNameController.text;
                  _tripModal.payer = tripController.payerNameController.text;
                  _tripModal.amount = int.parse(tripController.amountController.text);
                  tripController.tripModal.add(_tripModal);

                  save();

                  tripController.placeNameController.clear();
                  tripController.payerNameController.clear();
                  tripController.amountController.clear();
                  Get.to(PayerList());
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    AppPreference.setString("chatModal", json.encode(tripController.tripModal));
    final Iterable l = json.decode(AppPreference.getString("chatModal"));
    final List<TripModal> posts = List<TripModal>.from(l.map((model) => TripModal.fromJson(model)));
    log("postsposts----${posts.toList()}");
    // tripController.tripModal.clear();
    tripController.tripModal.addAll(posts);
  }
}
