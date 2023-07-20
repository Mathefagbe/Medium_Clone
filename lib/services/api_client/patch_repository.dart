import 'dart:convert';
import 'dart:io';
import 'package:dblog/main.dart';
import 'package:http/http.dart' as http;
import 'package:dblog/services/api_client/base_client.dart';
import '../exceptions/error_exceptions.dart';

class PatchHttpRepository {
  final http.Client client = http.Client();
  final BaseClientEndPoints api = BaseClientEndPoints();

  PatchHttpRepository._();

  //single tone class
  static final PatchHttpRepository patch = PatchHttpRepository._();

  Future<void> _patchData<T>({
    required Uri uri,
    required Function(dynamic data) builder,
    required Map formdata,
  }) async {
    try {
      var request = http.MultipartRequest("PATCH", uri);
      request.headers.addAll({'Authorization': 'Bearer $basetoken'});
      if (formdata['image'] == "") {
        request.fields['bio'] = formdata['bio'];
        var res = await request.send();
        if (res.statusCode == 200) {
        } else {
          ResponseErrorHandler.processErrorResponse(res);
        }
      } else {
        request.files.add(http.MultipartFile.fromBytes(
            "image", File(formdata['image']).readAsBytesSync(),
            filename: formdata['image'].split("/").last));
        request.fields['bio'] = formdata['bio'];
        var res = await request.send();
        if (res.statusCode == 200) {
        } else {
          ResponseErrorHandler.processErrorResponse(res);
        }
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

  Future<dynamic> patchUserProfile(Map formdata) {
    return _patchData(
      uri: api.updateprofile(),
      builder: (data) => null,
      formdata: formdata,
    );
  }

  Future<void> editPost(Map formdata, String slug) async {
    var uri = BaseClientEndPoints().editpost(slug);
    try {
      var request = http.MultipartRequest("PUT", uri);
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
}
