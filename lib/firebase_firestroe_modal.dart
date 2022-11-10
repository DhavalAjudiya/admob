// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flare/utils/enums.dart';
// import 'package:get/get.dart';
//
// class UserModel {
//   String? userID;
//   String? firstName;
//   String? lastName;
//   String? gender;
//   String? sexualOrientation;
//   String? email;
//   String? phoneNumber;
//   String? dateOfBirth;
//   bool? isTransGender;
//   String? fullName;
//   String? socialPersonality;
//   String? aboutMe;
//   List<String>? roles;
//   ImageImpression? imageImpression;
//   late GeoPoint geopoints;
//   List<String>? usersLikesMe;
//   List<String>? myLikes;
//   int? distance;
//   int? ageDiff;
//   late Timestamp? firstImpressionDateTime;
//   Map<String, dynamic>? friends;
//   String? lastMsgTimeFormat;
//   String? chattingWith;
//   Rx<ImagePic>? tinderRightTap;
//
//   UserModel({
//     this.userID = '',
//     this.firstName = '',
//     this.lastName = '',
//     this.gender = '',
//     this.sexualOrientation = '',
//     this.email = '',
//     this.dateOfBirth = '',
//     this.phoneNumber = '',
//     this.isTransGender = false,
//     this.imageImpression,
//     this.fullName = '',
//     this.socialPersonality = '',
//     this.aboutMe = '',
//     this.roles = const <String>[],
//     this.geopoints = const GeoPoint(0.0, 0.0),
//     this.usersLikesMe = const <String>[],
//     this.myLikes = const <String>[],
//     this.distance = 0,
//     this.ageDiff = 0,
//     this.firstImpressionDateTime,
//     this.lastMsgTimeFormat = '',
//     this.chattingWith = '',
//     this.friends = const {},
//     this.tinderRightTap,
//   }) {
//     tinderRightTap = ImagePic.firstImpression.obs;
//   }
//
//   UserModel.fromDocumentSnapshot(
//     DocumentSnapshot documentSnapshot,
//   ) {
//     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//     userID = data["userID"] ?? '';
//     firstName = data["firstName"] ?? '';
//     lastName = data["lastName"] ?? '';
//     fullName = data["fullName"] ?? '';
//     gender = data["gender"] ?? '';
//     sexualOrientation = data["sexualOrientation"] ?? '';
//     email = data["email"] ?? '';
//     dateOfBirth = data["dateOfBirth"] ?? '';
//     phoneNumber = data["phoneNumber"] ?? '';
//     isTransGender = data["isTransGender"] ?? false;
//     imageImpression = data['imageImpression'] != null ? ImageImpression.fromJson(data['imageImpression']) : null;
//     aboutMe = data["aboutMe"] ?? '';
//     chattingWith = data["chattingWith"] ?? '';
//     roles = List<String>.from(data["roles"] ?? []);
//     geopoints = (data["geopoints"] == null) || (data["geopoints"].runtimeType == Null) ? const GeoPoint(0.0, 0.0) : data["geopoints"];
//     usersLikesMe = data["usersLikesMe"] == null ? [] : List<String>.from(data["usersLikesMe"] ?? []);
//     myLikes = data["myLikes"] == null ? [] : List<String>.from(data["myLikes"]);
//     friends = Map.from(data["friends"] ?? {});
//     firstImpressionDateTime = data['firstImpressionDateTime'];
//   }
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     userID = json["userID"] ?? '';
//     firstName = json["firstName"] ?? '';
//     lastName = json["lastName"] ?? '';
//     fullName = json["fullName"] ?? '';
//     gender = json["gender"] ?? '';
//     sexualOrientation = json["sexualOrientation"] ?? '';
//     email = json["email"] ?? '';
//     dateOfBirth = json["dateOfBirth"] ?? '';
//     phoneNumber = json["phoneNumber"] ?? '';
//     isTransGender = json["isTransGender"] ?? false;
//     imageImpression = json['imageImpression'] != null ? ImageImpression.fromJson(json['imageImpression']) : null;
//     socialPersonality = json["socialPersonality"] ?? '';
//     aboutMe = json["aboutMe"] ?? '';
//
//     roles = List<String>.from(json["roles"] ?? []);
//     geopoints = (json["geopoints"] == null) || (json["geopoints"].runtimeType == Null) ? const GeoPoint(0.0, 0.0) : json["geopoints"];
//     usersLikesMe = json["usersLikesMe"] == null ? [] : List<String>.from(json["usersLikesMe"] ?? []);
//     myLikes = json["myLikes"] == null ? [] : List<String>.from(json["myLikes"]);
//     friends = json["friends"] == null ? {} : Map.from(json["friends"]);
//     firstImpressionDateTime = json["firstImpressionDateTime"];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userID'] = userID;
//     if (imageImpression != null) {
//       data['imageImpression'] = imageImpression!.toJson();
//     }
//     data['fullName'] = fullName;
//     data["firstName"] = firstName;
//     data["lastName"] = lastName;
//     data["gender"] = gender;
//     data["sexualOrientation"] = sexualOrientation;
//     data["email"] = email;
//     data["dateOfBirth"] = dateOfBirth;
//     data["phoneNumber"] = phoneNumber;
//     data["isTransGender"] = isTransGender;
//     data["socialPersonality"] = socialPersonality;
//     data["aboutMe"] = aboutMe;
//     data["roles"] = roles;
//     data["geopoints"] = geopoints;
//     data["usersLikesMe"] = usersLikesMe;
//     data["myLikes"] = myLikes;
//     data["friends"] = friends;
//     data["chattingWith"] = chattingWith;
//     data["firstImpressionDateTime"] = firstImpressionDateTime;
//     return data;
//   }
// }
//
// class ImageImpression {
//   String? firstImpression;
//   String? secondImpression;
//   String? thirdImpression;
//
//   ImageImpression({this.firstImpression, this.secondImpression, this.thirdImpression});
//
//   ImageImpression.fromJson(Map<String, dynamic> json) {
//     firstImpression = json['firstImpression'] ?? '';
//     secondImpression = json['secondImpression'] ?? '';
//     thirdImpression = json['thirdImpression'] ?? '';
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['firstImpression'] = firstImpression;
//     data['secondImpression'] = secondImpression;
//     data['thirdImpression'] = thirdImpression;
//     return data;
//   }
//
//   ImageImpression.fromDocumentSnapshot(
//     DocumentSnapshot documentSnapshot,
//   ) {
//     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//     firstImpression = data['firstImpression'] ?? '';
//     secondImpression = data['secondImpression'] ?? '';
//     thirdImpression = data['thirdImpression'] ?? '';
//   }
// }
