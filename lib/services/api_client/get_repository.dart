import 'package:dblog/model/following_model.dart';
import 'package:dblog/services/api_client/base_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';
import '../../model/blogposts_model.dart';
import '../../model/comment_model.dart';
import '../../model/detail_model.dart';
import '../exceptions/error_exceptions.dart';
import '../../model/follower_model.dart';
import '../../model/profile_model.dart';

class GetHttpRepository {
  final http.Client client = http.Client();
  final BaseClientEndPoints api = BaseClientEndPoints();

  GetHttpRepository._();
  //single tone class
  static final GetHttpRepository get = GetHttpRepository._();

  Future<dynamic> _getData({
    required Uri uri,
    required Function(dynamic data) builder,
  }) async {
    try {
      final res = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $basetoken'
      }).timeout(const Duration(seconds: 30));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return builder(data);
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

  Future<dynamic> getFollowers(int id) {
    return _getData(
      uri: api.followers(id),
      builder: (data) => data.map((e) => Follower.fromJson(e)).toList(),
    );
  }

  Future<dynamic> getFollowering(int id) {
    return _getData(
        uri: api.following(id),
        builder: (data) => data.map((e) => Following.fromJson(e)).toList());
  }

  Future getposts() {
    return _getData(
        uri: api.blogPosts(),
        builder: (data) {
          return data.map((e) => BlogPost.fromJson(e)).toList();
        });
  }

  Future<dynamic> getpost(String slug) {
    return _getData(
      uri: api.blogPost(slug),
      builder: (data) => PostDetail.fromJson(data),
    );
  }

  Future<dynamic> getsearchpost(String slug) {
    return _getData(
        uri: api.searchpost(slug),
        builder: (data) {
          return data.map((e) => BlogPost.fromJson(e)).toList();
        });
  }

  Future<dynamic> getcomment(String slug) {
    return _getData(
        uri: api.comment(slug),
        builder: (data) => data.map((e) => Comment.fromJson(e)).toList());
  }

  Future<dynamic> getauthorpost(int id) {
    return _getData(
        uri: api.authorposts(id),
        builder: (data) {
          return data.map((e) => BlogPost.fromJson(e)).toList();
        });
  }

  Future<dynamic> getuserpost() {
    return _getData(
        uri: api.userpost(),
        builder: (data) {
          return data.map((e) => BlogPost.fromJson(e)).toList();
        });
  }

  Future<dynamic> getuserprofile() {
    return _getData(
        uri: api.userprofile(),
        builder: (data) {
          return Profile.fromJson(data);
        });
  }

  Future<dynamic> getauthorprofile(int id) {
    return _getData(
        uri: api.authorprofile(id),
        builder: (data) {
          return Profile.fromJson(data);
        });
  }
}
