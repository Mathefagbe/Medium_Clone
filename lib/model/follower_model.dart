// To parse this JSON data, do
//
//     final follower = followerFromJson(jsonString);

import 'dart:convert';

List<Follower> followerFromJson(String str) =>
    List<Follower>.from(json.decode(str).map((x) => Follower.fromJson(x)));

String followerToJson(List<Follower> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Follower {
  UserFrom userFrom;
  String status;

  Follower({
    required this.userFrom,
    required this.status,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        userFrom: UserFrom.fromJson(json["user_from"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_from": userFrom.toJson(),
        "status": status,
      };
}

class UserFrom {
  int id;
  String username;
  String email;
  String firstName;
  Userprofile userprofile;
  DateTime lastLogin;

  UserFrom({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.userprofile,
    required this.lastLogin,
  });

  factory UserFrom.fromJson(Map<String, dynamic> json) => UserFrom(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        userprofile: Userprofile.fromJson(json["userprofile"]),
        lastLogin: DateTime.parse(json["last_login"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "first_name": firstName,
        "userprofile": userprofile.toJson(),
        "last_login": lastLogin.toIso8601String(),
      };
}

class Userprofile {
  String image;
  String bio;

  Userprofile({
    required this.image,
    required this.bio,
  });

  factory Userprofile.fromJson(Map<String, dynamic> json) => Userprofile(
        image: json["image"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "bio": bio,
      };
}
