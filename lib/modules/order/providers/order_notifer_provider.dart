//PROVIDER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/modules/order/logic/order_notifier.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/providers/order_repo_provider.dart';
import 'package:media_design_assingment_app/network/api_response.dart';

final orderNotifierProvider = StateNotifierProvider<
  OrderNotifier,
  ApiResponse<List<ProductModel>>
>((ref) {
  return OrderNotifier(orderRepository: ref.read(providerOfOrderRepository));
});
