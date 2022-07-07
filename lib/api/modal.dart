// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

HomePageModel homePageModelFromJson(String str) =>
    HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.code,
    this.topicList,
  });

  int? code;
  TopicList? topicList;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        code: json["code"],
        topicList: TopicList.fromJson(json["topicList"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "topicList": topicList!.toJson(),
      };
}

class TopicList {
  TopicList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    required this.selected,
    required this.shareSelected,
  });

  RxBool selected = false.obs;
  RxBool shareSelected = false.obs;

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory TopicList.fromJson(Map<String, dynamic> json) => TopicList(
        currentPage: json["current_page"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? "",
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? "",
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] ?? "",
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
        selected: false.obs,
        shareSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.userToken,
    this.title,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.geoCountry,
    this.likesCount,
    this.bookmarkCount,
    this.commentsCount,
    this.sharesCount,
    this.user,
    this.comments,
    required this.saveSelected,
  });
  RxBool saveSelected = false.obs;
  int? id;
  String? userToken;
  String? title;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic geoCountry;
  String? likesCount;
  String? bookmarkCount;
  String? commentsCount;
  String? sharesCount;
  User? user;
  List<Comment>? comments;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        userToken: json["user_id"] ?? "",
        title: json["title"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        geoCountry: json["geo_country"] ?? "",
        likesCount: json["likes_count"] ?? "",
        bookmarkCount: json["bookmark_count"] ?? "",
        commentsCount: json["comments_count"] ?? "",
        sharesCount: json["shares_count"] ?? "",
        user: User.fromJson(json["user"] ?? ""),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        saveSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userToken,
        "title": title,
        "is_deleted": isDeleted,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "geo_country": geoCountry,
        "likes_count": likesCount,
        "bookmark_count": bookmarkCount,
        "comments_count": commentsCount,
        "shares_count": sharesCount,
        "user": user!.toJson(),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.topicId,
    this.userToken,
    this.comment,
    this.hasImage,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
    this.replyCount,
    this.user,
    this.commentmedia,
    this.reply,
  });

  int? id;
  String? topicId;
  String? userToken;
  String? comment;
  String? hasImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? likesCount;
  String? replyCount;
  User? user;
  List<dynamic>? commentmedia;
  List<Reply>? reply;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] ?? 0,
        topicId: json["topic_id"] ?? "",
        userToken: json["user_id"] ?? "",
        comment: json["comment"] ?? "",
        hasImage: json["has_image"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        likesCount: json["likes_count"] ?? "",
        replyCount: json["reply_count"] ?? "",
        user: User.fromJson(json["user"] ?? ""),
        commentmedia: List<dynamic>.from(json["commentmedia"].map((x) => x)),
        reply: json["reply"] == null
            ? null
            : List<Reply>.from(json["reply"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topicId,
        "user_id": userToken,
        "comment": comment,
        "has_image": hasImage,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "likes_count": likesCount,
        "reply_count": replyCount,
        "user": user!.toJson(),
        "commentmedia": List<dynamic>.from(commentmedia!.map((x) => x)),
        "reply": List<dynamic>.from(reply!.map((x) => x.toJson())),
      };
}

class Reply {
  Reply({
    this.id,
    this.commentId,
    this.reply,
    this.replyBy,
    this.topicId,
    this.hasImage,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
    this.replymedia,
    this.user,
  });

  int? id;
  String? commentId;
  String? reply;
  String? replyBy;
  String? topicId;
  String? hasImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? likesCount;
  List<Replymedia>? replymedia;
  User? user;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"] ?? 0,
        commentId: json["comment_id"] ?? "",
        reply: json["reply"] ?? "",
        replyBy: json["reply_by"] ?? "",
        topicId: json["topic_id"] ?? "",
        hasImage: json["has_image"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        likesCount: json["likes_count"] ?? "",
        replymedia: List<Replymedia>.from(
            json["replymedia"].map((x) => Replymedia.fromJson(x))),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment_id": commentId,
        "reply": reply,
        "reply_by": replyBy,
        "topic_id": topicId,
        "has_image": hasImage,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "likes_count": likesCount,
        "replymedia": List<dynamic>.from(replymedia!.map((x) => x.toJson())),
        "user": user!.toJson(),
      };
}

class Replymedia {
  Replymedia({
    this.id,
    this.replyId,
    this.commentId,
    this.topicId,
    this.mediaPath,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? replyId;
  String? commentId;
  String? topicId;
  String? mediaPath;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Replymedia.fromJson(Map<String, dynamic> json) => Replymedia(
        id: json["id"] ?? 0,
        replyId: json["reply_id"] ?? "",
        commentId: json["comment_id"] ?? "",
        topicId: json["topic_id"] ?? "",
        mediaPath: json["media_path"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reply_id": replyId,
        "comment_id": commentId,
        "topic_id": topicId,
        "media_path": mediaPath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class User {
  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.code,
      this.emailVerifiedAt,
      this.profile,
      this.location,
      this.bio,
      this.private,
      this.twoFactorAuth,
      this.isEmailUpdate,
      this.isDeactive,
      this.createdAt,
      this.updatedAt,
      this.notiToken,
      this.geoCountry,
      required this.replayLike,
      this.uTitle});

  RxBool replayLike = false.obs;
  int? id;
  String? name;
  String? uTitle;

  String? username;
  String? email;
  dynamic code;
  DateTime? emailVerifiedAt;
  String? profile;
  String? location;
  String? bio;
  String? private;
  dynamic twoFactorAuth;
  dynamic isEmailUpdate;
  String? isDeactive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? notiToken;
  dynamic geoCountry;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        uTitle: json["name"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        code: json["code"] ?? 0,
        emailVerifiedAt:
            DateTime.parse(json["email_verified_at"] ?? DateTime.now()),
        profile: json["profile"] ?? "",
        location: json["location"] ?? "",
        bio: json["bio"] ?? "",
        private: json["private"] ?? "",
        twoFactorAuth: json["two_factor_auth"] ?? "",
        isEmailUpdate: json["is_email_update"] ?? "",
        isDeactive: json["is_deactive"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        notiToken: json["noti_token"] ?? "",
        geoCountry: json["geo_country"] ?? "",
        replayLike: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "uTitle": uTitle,
        "username": username,
        "email": email,
        "code": code,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "profile": profile,
        "location": location,
        "bio": bio,
        "private": private,
        "two_factor_auth": twoFactorAuth,
        "is_email_update": isEmailUpdate,
        "is_deactive": isDeactive,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "noti_token": notiToken,
        "geo_country": geoCountry,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
