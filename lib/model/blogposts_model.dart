// To parse this JSON data, do
//
//     final blogPost = blogPostFromJson(jsonString);

import 'dart:convert';

List<BlogPost> blogPostFromJson(String str) =>
    List<BlogPost>.from(json.decode(str).map((x) => BlogPost.fromJson(x)));

String blogPostToJson(List<BlogPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogPost {
  BlogPost({
    required this.title,
    required this.image,
    required this.author,
    required this.slug,
    required this.body,
    required this.timeAgo,
  });

  String title;
  String image;
  Author author;
  String slug;
  String timeAgo;
  String body;

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
      title: json["title"],
      image: json["image"],
      author: Author.fromJson(json["author"]),
      slug: json["slug"],
      timeAgo: json["time_ago"],
      body: json["body"]);

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "author": author.toJson(),
        "slug": slug,
        "time_ago": timeAgo,
        '"body': body
      };
}

class Author {
  Author({
    required this.id,
    required this.username,
    // required this.email,
    // required this.firstName,
    required this.userprofile,
    // required this.lastLogin,
  });

  int id;
  String username;
  // String email;
  // String firstName;
  Userprofile userprofile;
  // DateTime lastLogin;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        username: json["username"],
        // email: json["email"],
        // firstName: json["first_name"],
        userprofile: Userprofile.fromJson(json["userprofile"]),
        // lastLogin: DateTime.parse(json["last_login"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        // "email": email,
        // "first_name": firstName,
        "userprofile": userprofile.toJson(),
        // "last_login": lastLogin.toIso8601String(),
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
