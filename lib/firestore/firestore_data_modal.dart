import 'package:cloud_firestore/cloud_firestore.dart';

class NewPostModel {
  String? title;
  String? description;
  String? postImage;
  String? userImage;
  String? locationTitle;
  String? locationSubTitle;
  String? batteryStatus;
  String? time;
  String? userId;
  String? docId;
  String? type;
  late GeoPoint geopoints;

  NewPostModel(
      {this.title,
      this.description,
      this.postImage,
      this.userImage,
      this.locationTitle,
      this.locationSubTitle,
      this.batteryStatus,
      this.time,
      this.userId,
      this.docId,
      this.geopoints = const GeoPoint(0.0, 0.0),
      this.type}) {}

  NewPostModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    title = data["title"] ?? '';
    description = data["description"] ?? '';
    postImage = data["postImage"] ?? '';
    userImage = data["userImage"] ?? '';
    locationTitle = data["locationTitle"] ?? '';
    locationSubTitle = data["locationSubTitle"] ?? '';
    batteryStatus = data["batteryStatus"] ?? '';
    time = data["time"] ?? '';
    userId = data["userId"] ?? '';
    docId = data["docId"] ?? '';
    type = data["type"] ?? '';
    geopoints = (data["geopoints"] == null) || (data["geopoints"].runtimeType == Null) ? const GeoPoint(0.0, 0.0) : data["geopoints"];
  }

  NewPostModel.fromJson(Map<String, dynamic> json) {
    title = json["title"] ?? '';
    description = json["description"] ?? '';
    postImage = json["postImage"] ?? '';
    userImage = json["userImage"] ?? '';
    locationTitle = json["locationTitle"] ?? '';
    locationSubTitle = json["locationSubTitle"] ?? '';
    batteryStatus = json["batteryStatus"] ?? '';
    time = json["time"] ?? '';
    userId = json["userId"] ?? '';
    docId = json["docId"] ?? '';
    type = json["type"] ?? '';
    geopoints = (json["geopoints"] == null) || (json["geopoints"].runtimeType == Null) ? const GeoPoint(0.0, 0.0) : json["geopoints"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['postImage'] = postImage;
    data['userImage'] = userImage;
    data['locationTitle'] = locationTitle;
    data['locationSubTitle'] = locationSubTitle;
    data['batteryStatus'] = batteryStatus;
    data['time'] = time;
    data['userId'] = userId;
    data['docId'] = docId;
    data['type'] = type;
    data["geopoints"] = geopoints;

    return data;
  }
}
