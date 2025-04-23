import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/modules/order/repository/order_repository.dart';
import 'package:media_design_assingment_app/modules/order/repository/order_repository_imp.dart';
import 'package:media_design_assingment_app/network/api_service_provider.dart';

final providerOfOrderRepository = Provider<OrderRepository>(
  (ref) => OrderRepositoryImp(ref.read(providerOfApiService)),
);
