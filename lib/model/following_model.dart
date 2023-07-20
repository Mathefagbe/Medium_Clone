// To parse this JSON data, do
//
//     final following = followingFromJson(jsonString);

import 'dart:convert';

List<Following> followingFromJson(String str) =>
    List<Following>.from(json.decode(str).map((x) => Following.fromJson(x)));

String followingToJson(List<Following> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Following {
  UserTo userTo;
  String status;

  Following({
    required this.userTo,
    required this.status,
  });

  factory Following.fromJson(Map<String, dynamic> json) => Following(
        userTo: UserTo.fromJson(json["user_to"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_to": userTo.toJson(),
        "status": status,
      };
}

class UserTo {
  int id;
  String username;
  String email;
  String firstName;
  Userprofile userprofile;
  DateTime lastLogin;

  UserTo({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.userprofile,
    required this.lastLogin,
  });

  factory UserTo.fromJson(Map<String, dynamic> json) => UserTo(
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
