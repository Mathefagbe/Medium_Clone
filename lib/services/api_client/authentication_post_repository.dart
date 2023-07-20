import 'dart:convert';
import 'package:dblog/main.dart';
import 'package:http/http.dart' as http;
import 'package:dblog/services/api_client/base_client.dart';
import '../exceptions/error_exceptions.dart';
import '../../model/token_model.dart';
import '../local_storage/tokenstorage.dart';

class PostAutheniticationHttpRepository {
  final http.Client client = http.Client();
  final BaseClientEndPoints api = BaseClientEndPoints();

  PostAutheniticationHttpRepository._();

  //single tone class
  static final PostAutheniticationHttpRepository post =
      PostAutheniticationHttpRepository._();

  Future<dynamic> _authenticateUser({
    required Uri uri,
    required Function(dynamic data) builder,
    required Map formdata,
  }) async {
    try {
      final res = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(formdata));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return builder(data);
      } else if (res.statusCode == 204) {
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }

  Future<dynamic> login(Map formdata) {
    return _authenticateUser(
      uri: api.login(),
      builder: (data) {
        Token token = Token.fromJson(data);
        naviagtorkey.currentState?.pushReplacementNamed('/nav');
        basetoken = token.token;
        LocalDatabase.init.setToken(basetoken);
        return basetoken;
      },
      formdata: formdata,
    );
  }

  Future<dynamic> signup(Map formdata) {
    return _authenticateUser(
      uri: api.signup(),
      builder: (data) {
        Token token = Token.fromJson(data);
        naviagtorkey.currentState?.pushReplacementNamed('/nav');
        basetoken = token.token;
        LocalDatabase.init.setToken(basetoken);
        return basetoken;
      },
      formdata: formdata,
    );
  }

  Future<void> logout() async {
    try {
      final res = await client.post(
        api.logout(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $basetoken'
        },
      );
      if (res.statusCode == 204) {
        naviagtorkey.currentState?.pushReplacementNamed('/login');
      } else {
        ResponseErrorHandler.processErrorResponse(res);
      }
    } catch (e) {
      ExceptionHandler.getExceptionString(e);
    }
  }
}
