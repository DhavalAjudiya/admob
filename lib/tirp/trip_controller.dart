import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/tirp/trip_modal.dart';

class TripController extends GetxController {
  TextEditingController placeNameController = TextEditingController();
  TextEditingController payerNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  RxList<TripModal> tripModal = <TripModal>[].obs;
}
