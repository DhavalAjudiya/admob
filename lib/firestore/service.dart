import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_data_modal.dart';

Future<void> insertNewPostData(NewPostModel data) async {
  String id = FirebaseFirestore.instance.collection("NewPost").doc().id;
  print("docsid===>>>$id");
  data.docId = id;
  print("docsid===>>>${data.docId}");
  await FirebaseFirestore.instance
      .collection("NewPost")
      .doc()
      .collection("NewPost")
      .doc(id)
      .set(
        data.toJson(),
        SetOptions(merge: true),
      )
      .catchError((error) => print("Failed to add user: $error"));
}

//
// await AppConstant.databaseReference
//     .collection("NewPost")
// .where("userId", isEqualTo: AppSharedPreference.userId)
// .get()
//     .then((QuerySnapshot<Map<String, dynamic>> value) {
// value.docs.forEach((element) {
// print("element==>>>${element.data()}");
// allUserPostModel.value = NewPostModel.fromDocumentSnapshot(element);
// allUserPostList.value.add(allUserPostModel.value);
// });
