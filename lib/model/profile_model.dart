// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String image;
  String bio;
  User user;
  int followers;
  int following;

  Profile({
    required this.image,
    required this.bio,
    required this.user,
    required this.followers,
    required this.following,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        image: json["image"],
        bio: json["bio"],
        user: User.fromJson(json["user"]),
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "bio": bio,
        "user": user.toJson(),
        "followers": followers,
        "following": following,
      };
}

class User {
  String username;
  String email;
  String firstName;
  int id;

  User(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      id: json['id']);

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "first_name": firstName,
        "id": id,
      };
}
