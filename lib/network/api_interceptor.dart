// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = "application/json";

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401:
        {
          debugPrint(
            'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
          );
          break;
        }
      case 403:
        {
          debugPrint(
            'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
          );
          break;
        }
      case 404:
        {
          debugPrint(
            'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
          );
          break;
        }
      default:
        debugPrint(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
        );
    }

    return super.onError(err, handler);
  }
}
