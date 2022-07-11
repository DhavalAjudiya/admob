import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/api/modal.dart';
import 'package:testadmob/api/services.dart';

class Controller extends GetxController {
  Rx<HomePageModel> fetchData = HomePageModel().obs;
  ScrollController scrollController = ScrollController();
  RxList<Datum> data = <Datum>[].obs;
  int select = 0;
  RxBool isPagination = false.obs;

  @override
  void onInit() {
    print("-------12------");

    fatchData();
    print("-------123------");
    //  scrollController.positions.p(index,
    //     preferPosition: AutoScrollPosition.begin);
    // scrollController.highlight(index);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print("pixel ==>>${scrollController.position.pixels}");
        print("-------select------");

        nextData();
        print("-------12345------");
      }
    });
    super.onInit();
  }

  void scrollup() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeInCubic,
    );
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeInCubic,
    );
  }

  void fatchData() async {
    try {
      final result = await FetchApiService.getFetchData();
      fetchData.value = result as HomePageModel;

      // for (var element in fetchData.value) {
      //   for ( var index in element.topicList?.data ?? []) {
      //
      //     index.user?.uTitle= element.topicList?.data?.first.title;
      //     // index.department = element.departmentName;
      //     // index.departmentID = element.department;
      //     // if (index.status == "A") {
      //     //   index.statusItemValue = "Approved";
      //     // } else if (index.status == "R") {
      //     //   index.statusItemValue = "Rejected";
      //     // } else if (index.status == "O") {
      //     //   index.statusItemValue = "Pending";
      //     } else {}
      //     staffLeaveDetail.add(staffLeaveDetailList);
      //   }
      // // }

      if (fetchData.value.topicList!.data!.isNotEmpty) {
        data.addAll(fetchData.value.topicList!.data!);
        print("data==>>>>${data.length}");
      }
    } catch (e, st) {
      log('fatchData:---->> 000->>$e && st is:-->>$st');
    }
  }

  void nextData() async {
    try {
      select++;
      print("select---------->>>${select}");
      final result = await FetchApiService.getFetchData();
      fetchData.value = result as HomePageModel;
      if (fetchData.value.topicList!.data!.isNotEmpty) {
        data.addAll(fetchData.value.topicList!.data!);
        print("data==>>>>${data.length}");
      }
    } catch (e, st) {
      print("nextdata ======---->>>>>>${e}////${st}");
    } finally {
      //
    }
  }
}
