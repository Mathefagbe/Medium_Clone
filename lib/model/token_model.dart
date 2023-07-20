// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.expiry,
    required this.token,
    required this.user,
  });

  DateTime expiry;
  String token;
  User user;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        expiry: DateTime.parse(json["expiry"]),
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "expiry": expiry.toIso8601String(),
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.userprofile,
    required this.lastLogin,
  });

  int id;
  String username;
  String email;
  String firstName;
  Userprofile userprofile;
  DateTime lastLogin;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  Userprofile({
    required this.image,
  });

  String image;

  factory Userprofile.fromJson(Map<String, dynamic> json) => Userprofile(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
