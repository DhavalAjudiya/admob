import 'dart:convert';

import 'package:get/get.dart';
import 'package:testadmob/tirp/shared_preference.dart';
import 'package:testadmob/tirp/trip_modal.dart';

class PayerController extends GetxController {
  RxList<TripModal> tripModal = <TripModal>[].obs;

  @override
  void onInit() {
    if (AppPreference.getString("chatModal") != "") {
      final Iterable l = json.decode(AppPreference.getString("chatModal"));
      final List<TripModal> posts = List<TripModal>.from(l.map((model) => TripModal.fromJson(model)));
      tripModal.clear();
      tripModal.addAll(posts);
    }
    super.onInit();
  }
}
