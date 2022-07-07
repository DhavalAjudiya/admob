// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.userData,
    this.bannerIdAndroid,
  });

  UserDataClass? userData;
  String? bannerIdAndroid;

  factory UserData.fromJson(map) {
    print("map------>$map");
    return UserData(
      userData: UserDataClass.fromJson(map["UserData"]),
      bannerIdAndroid: map["banner_id_android"],
    );
  }

  Map<String, dynamic> toJson() => {
        "UserData": userData!.toJson(),
        "banner_id_android": bannerIdAndroid,
      };
}

class UserDataClass {
  UserDataClass({
    this.user,
  });

  User? user;

  factory UserDataClass.fromJson(Map<String, dynamic> json) => UserDataClass(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.email,
    this.friendMap,
    this.hobby,
    this.number,
    this.password,
  });

  String? email;
  FriendMap? friendMap;
  List<String>? hobby;
  String? number;
  String? password;

  factory User.fromJson(json) {
    print("heyyyyyyy    ====>${json["email"]}");
    return User(
      email: json["email"].toString(),
      friendMap: FriendMap.fromJson(json["friendMap"]),
      hobby: List<String>.from(json["hobby"].map((x) => x)),
      number: json["number"].toString(),
      password: json["password"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "friendMap": friendMap!.toJson(),
        "hobby": List<dynamic>.from(hobby!.map((x) => x)),
        "number": number,
        "password": password,
      };
}

class FriendMap {
  FriendMap({
    this.clgfriend,
    this.schoolFriend,
  });

  List<Friend>? clgfriend;
  List<Friend>? schoolFriend;

  factory FriendMap.fromJson(json) => FriendMap(
        clgfriend:
            List<Friend>.from(json["clgfriend"].map((x) => Friend.fromJson(x))),
        schoolFriend: List<Friend>.from(
            json["schoolFriend"].map((x) => Friend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clgfriend": List<dynamic>.from(clgfriend!.map((x) => x.toJson())),
        "schoolFriend":
            List<dynamic>.from(schoolFriend!.map((x) => x.toJson())),
      };
}

class Friend {
  Friend({
    this.name,
    this.sirName,
  });

  String? name;
  String? sirName;

  factory Friend.fromJson(json) => Friend(
        name: json["name"],
        sirName: json["sirName"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sirName": sirName,
      };
}
