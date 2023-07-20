// To parse this JSON data, do
//
//     final postDetail = postDetailFromJson(jsonString);

import 'dart:convert';

PostDetail postDetailFromJson(String str) =>
    PostDetail.fromJson(json.decode(str));

String postDetailToJson(PostDetail data) => json.encode(data.toJson());

class PostDetail {
  PostDetail({
    required this.post,
    required this.status,
    required this.likestatus,
  });

  Post post;
  String status;
  String likestatus;

  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
      post: Post.fromJson(json["post"]),
      status: json["status"],
      likestatus: json["likestatus"]);

  Map<String, dynamic> toJson() => {
        "post": post.toJson(),
        "status": status,
        "likestatus": likestatus,
      };
}

class Post {
  Post(
      {required this.title,
      required this.body,
      required this.author,
      required this.image,
      required this.slug,
      required this.commentCount,
      required this.timeAgo,
      required this.like});

  String title;
  String body;
  Author author;
  String image;
  String slug;
  int commentCount;
  String timeAgo;
  int like;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      title: json["title"],
      body: json["body"],
      author: Author.fromJson(json["author"]),
      image: json["image"],
      slug: json["slug"],
      commentCount: json["comment_count"],
      timeAgo: json["time_ago"],
      like: json['like']);

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "author": author.toJson(),
        "image": image,
        "slug": slug,
        "comment_count": commentCount,
        "time_ago": timeAgo,
        'like': like,
      };
}

class Author {
  Author({
    required this.id,
    required this.username,
    required this.userprofile,
  });

  int id;
  String username;

  Userprofile userprofile;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        username: json["username"],
        userprofile: Userprofile.fromJson(json["userprofile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "userprofile": userprofile.toJson(),
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
