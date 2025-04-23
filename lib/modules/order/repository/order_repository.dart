import 'package:dartz/dartz.dart';
import 'package:media_design_assingment_app/network/api_exception.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<String>>> getDefaultProducts();
}
