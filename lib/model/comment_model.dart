// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.author,
    required this.timeAgo,
    required this.comment,
    required this.commentDate,
  });

  Author author;
  String timeAgo;
  String comment;
  DateTime commentDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        author: Author.fromJson(json["author"]),
        timeAgo: json["time_ago"],
        comment: json["comment"],
        commentDate: DateTime.parse(json["comment_date"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "time_ago": timeAgo,
        "comment": comment,
        "comment_date": commentDate.toIso8601String(),
      };
}

class Author {
  Author({
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

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
