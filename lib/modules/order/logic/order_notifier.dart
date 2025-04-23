// ignore_for_file: unused_field

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/repository/order_repository.dart';
import 'package:media_design_assingment_app/network/api_response.dart';
import 'package:media_design_assingment_app/widgets/primary_toast.dart';

class OrderNotifier extends StateNotifier<ApiResponse<List<ProductModel>>> {
  final OrderRepository _orderRepository;
  List<String> _defaultProducts = [];

  OrderNotifier({required OrderRepository orderRepository})
    : _orderRepository = orderRepository,
      super(ApiResponse.idle('Idle State'));

  List<String> get defaultProducts => _defaultProducts;
  List<ProductModel> get products => state.data ?? [];

  void _updateState(ApiResponse<List<ProductModel>> newState) {
    if (mounted) {
      state = newState;
    }
  }

  //Fetch products from api
  Future<void> fetchDefaultProducts() async {
    _updateState(ApiResponse.loading('Loading Products'));
    await _orderRepository.getDefaultProducts().then(
      (value) => value.fold(
        (error) {
          _updateState(ApiResponse.error(error.message));
          PrimaryToast(message: error.message);
        },
        (result) {
          _defaultProducts = result;
          _updateState(ApiResponse.completed([]));
        },
      ),
    );
  }

  void addProduct(ProductModel product) {
    final currentProducts = List<ProductModel>.from(products);
    currentProducts.add(product);
    _updateState(ApiResponse.completed(currentProducts));
  }

  void updateProduct(int index, ProductModel product) {
    final currentProducts = List<ProductModel>.from(products);
    if (index < currentProducts.length) {
      currentProducts[index] = product;
      _updateState(ApiResponse.completed(currentProducts));
    }
  }
}
