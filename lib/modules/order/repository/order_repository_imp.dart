import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_design_assingment_app/modules/order/repository/order_repository.dart';
import 'package:media_design_assingment_app/network/api_endpoint.dart';
import 'package:media_design_assingment_app/network/api_exception.dart';
import 'package:media_design_assingment_app/network/api_service.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';

class OrderRepositoryImp extends OrderRepository {
  OrderRepositoryImp(ApiService apiService) : _apiService = apiService;
  final ApiService _apiService;

  @override
  Future<Either<Failure, List<String>>> getDefaultProducts() async {
    try {
      var response = await _apiService.get(ApiEndpoint.sample);
      if (response != null) {
        final decoded = json.decode(response);
        if (decoded is Map<String, dynamic>) {
          final products = decoded.values.map((e) => e.toString()).toList();
          return right(products);
        }
        return left(Failure(message: AppStrings.noProductsFound));
      }
      return left(Failure(message: AppStrings.noProductsFound));
    } on ApiException catch (error) {
      return left(
        Failure(message: error.message ?? AppStrings.noProductsFound),
      );
    } on DioException catch (error) {
      return left(
        Failure(message: error.message ?? AppStrings.noProductsFound),
      );
    }
  }
}
