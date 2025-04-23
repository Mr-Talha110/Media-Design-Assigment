import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/network/api_contract.dart';
import 'package:media_design_assingment_app/network/api_endpoint.dart';
import 'package:media_design_assingment_app/network/api_exception.dart';
import 'package:media_design_assingment_app/network/api_interceptor.dart';

class ApiService implements ApiContract {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndpoint.baseUrl))
    ..interceptors.add(ApiInterceptor());

  @override
  Future<String?> get(String path, [Map<String, dynamic>? query]) async {
    debugPrint("GET => PATH: /$path PARAMS: $query");
    try {
      dio.options.connectTimeout = const Duration(milliseconds: 10000);
      final Response<String> response = await dio.get(
        path,
        queryParameters: query,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on SocketException {
      throw NoInternetException(
        'Internet is not connected please check your Internet',
      );
    } on HttpException {
      throw NoInternetException('Internet connection not found');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException(
          'Internet is not connected please check your Internet',
        );
      }
      debugPrint(
        "Error loading data, Something is wrong with the request params or API itself",
      );
      _returnException(e.response);
    }
    return null;
  }

  AppExceptionDio _returnException(Response<dynamic>? response) {
    switch (response?.statusCode) {
      case 400:
        Map<String, dynamic> data = json.decode(response?.data);
        throw InvalidCredentialsException(data['message'], response?.data[0]);
      case 403:
        throw UnauthorisedException(response?.data);
      case 401:
        throw IncorrectUsernameOrPassword(response?.data);
      case 404:
        throw UserNotFoundException(response?.data.toString() ?? '');
      case 429:
        throw TooManyRequestsException('');
      case 500:
        throw InternalServerException(
          'Looks like there is an issue communicating with our servers, Please try again later',
        );
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response?.statusCode}',
        );
    }
  }
}
