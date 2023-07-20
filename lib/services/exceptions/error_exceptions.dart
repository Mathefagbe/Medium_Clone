import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../main.dart';

class ExceptionFailuresMessage {
  final String message;
  const ExceptionFailuresMessage({required this.message});

  @override
  String toString() {
    return message;
  }
}

class ExceptionHandler {
  static getExceptionString(error) {
    if (error is SocketException) {
      throw const ExceptionFailuresMessage(message: "No Internet Connection");
    } else if (error is HttpException) {
      throw const ExceptionFailuresMessage(message: "Http Error Occured");
    } else if (error is FormatException) {
      throw const ExceptionFailuresMessage(message: "Invalid Data Format");
    } else if (error is TimeoutException) {
      throw const ExceptionFailuresMessage(message: "Request Timeout");
    } else if (error is HandshakeException) {
      throw const ExceptionFailuresMessage(
          message: "Error in client connection");
    } else {
      throw ExceptionFailuresMessage(message: error.toString());
    }
  }
}

class ResponseErrorHandler {
  static processErrorResponse(response) {
    switch (response.statusCode) {
      case 400:
        throw ExceptionFailuresMessage(
          message: jsonDecode(response.body)['detail'],
        );

      case 401:
        naviagtorkey.currentState?.pushReplacementNamed("/login");
        throw ExceptionFailuresMessage(
          message: jsonDecode(response.body)['detail'],
        );
      case 403:
        throw ExceptionFailuresMessage(
          message: jsonDecode(response.body)['detail'],
        );
      case 404:
        throw ExceptionFailuresMessage(
          message: jsonDecode(response.body)['detail'],
        );
      case 500:
        throw const ExceptionFailuresMessage(
          message: "Internal Server Error",
        );
      default:
        throw const ExceptionFailuresMessage(message: "Fetch exception");
    }
  }
}
