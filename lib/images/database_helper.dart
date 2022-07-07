import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  // static final CollectionReference _collectionReference =
  //     _firebaseFirestore.collection('addQr');
  static final CollectionReference qrScannerCollectionReference =
      _firebaseFirestore.collection('img');

  // static Future<void> addQR({
  //   required String title,
  //   required String subTitle,
  // }) async {
  //   DocumentReference documentReferencer = _collectionReference.doc();
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "subTitle": subTitle,
  //   };
  //
  //   await documentReferencer
  //       .set(data)
  //       .whenComplete(() => print("Checklist added"))
  //       .catchError((e) => print(e));
  // }
  //
  // static Stream<QuerySnapshot> getQR() {
  //   CollectionReference checklistItemCollection =
  //       _firebaseFirestore.collection('addQr');
  //
  //   return checklistItemCollection.snapshots();
  // }

  // ///----- scanner
  // static Future<void> qrScanner({
  //   required String title,
  //   required Timestamp time,
  // }) async {
  //   DocumentReference documentReferencer = qrScannerCollectionReference.doc();
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "qrData": title,
  //     "time": time,
  //   };
  //
  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("Checklist added"))
  //       .catchError((e) => print(e));
  // }

  static Stream<QuerySnapshot> getNatureImage() {
    CollectionReference checklistItemCollection =
        _firebaseFirestore.collection('nature');

    return checklistItemCollection.snapshots();
  }

  static Future<void> updateNature({
    required bool ch,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firebaseFirestore.collection('nature').doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "ch": ch,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteNature({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firebaseFirestore.collection('nature').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getAnimal() {
    CollectionReference checklistItemCollection =
        _firebaseFirestore.collection('god');

    return checklistItemCollection.snapshots();
  }

  static Future<void> updateAnimal({
    required bool ch,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firebaseFirestore.collection('god').doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "ch": ch,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getCarImage() {
    CollectionReference checklistItemCollection =
        _firebaseFirestore.collection('car');

    return checklistItemCollection.snapshots();
  }

  static Future<void> updateCar({
    required bool ch,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firebaseFirestore.collection('car').doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "ch": ch,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }
}
