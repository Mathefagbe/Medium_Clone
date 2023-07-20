import 'dart:convert';
import 'package:dblog/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dblog/services/api_client/base_client.dart';
import '../exceptions/error_exceptions.dart';

class PostHttpRepository {
  final http.Client client = http.Client();
  final BaseClientEndPoints api = BaseClientEndPoints();

  PostHttpRepository._();

  //single tone class
  static final PostHttpRepository post = PostHttpRepository._();

  Future<dynamic> _postData({
    required Uri uri,
    required Function(dynamic data) builder,
    required Map formdata,
  }) async {
    try {
      final res = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $basetoken'
          },
          body: jsonEncode(formdata));
      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        return builder(data);
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

// post request without form eg likes
  Future<dynamic> _postDataWithoutFormData({
    required Uri uri,
    required Function(dynamic data) builder,
  }) async {
    try {
      final res = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $basetoken'
        },
      );
      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        return builder(data);
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

  Future<dynamic> postComment(Map formdata, String slug) {
    return _postData(
      uri: api.postcomment(slug),
      builder: (data) => null,
      formdata: formdata,
    );
  }

  Future<dynamic> followeruser(Map formdata, context) {
    return _postData(
      formdata: formdata,
      uri: api.postfollowing(),
      builder: (data) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            duration: const Duration(seconds: 3),
            content: Text(
              "Author ${data['status']} successfully",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )));
      },
    );
  }

  Future<dynamic> likepost(slug, context) {
    return _postDataWithoutFormData(
      uri: api.likepost(slug),
      builder: (data) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            duration: const Duration(seconds: 3),
            content: Text(
              "You ${data['status']} this post ",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )));
      },
    );
  }

  //Create post that involve multipart request
  //
  Future<void> createPost(Map formdata) async {
    var uri = BaseClientEndPoints().createpost();
    try {
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll({'Authorization': 'Bearer $basetoken'});
      request.files.add(http.MultipartFile.fromBytes(
          "image", base64Decode(formdata['image']),
          filename: 'postimg.jpg'));
      request.fields['body'] = formdata['body'];
      request.fields['title'] = formdata['title'];
      var res = await request.send();
      if (res.statusCode == 201) {
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

  // delete a post
  Future<void> delete(slug) async {
    try {
      final res = await client.delete(
        api.deletepost(slug),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $basetoken'
        },
      );
      if (res.statusCode == 204) {
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }
}
