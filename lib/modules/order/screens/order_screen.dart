import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/providers/order_notifer_provider.dart';
import 'package:media_design_assingment_app/modules/order/screens/components/edit_product_sheet.dart';
import 'package:media_design_assingment_app/modules/order/screens/components/table_text_field.dart';
import 'package:media_design_assingment_app/network/api_response.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';
import 'package:media_design_assingment_app/utils/extensions/space_extension.dart';
import 'package:media_design_assingment_app/utils/routes/app_router.dart';
import 'package:media_design_assingment_app/widgets/primary_appbar.dart';
import 'package:media_design_assingment_app/widgets/primary_toast.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  //Controllers and Focus nodes for table fields
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> productControllers = [];
  List<FocusNode> quantityFocusNodes = [];
  List<FocusNode> productFocusNodes = [];

  //Fetching defualt products on init
  @override
  void initState() {
    super.initState();
    _addRows(10);
    Future.microtask(
      () => ref.read(orderNotifierProvider.notifier).fetchDefaultProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(orderNotifierProvider.notifier);
    final state = ref.watch(orderNotifierProvider);
    return Scaffold(
      appBar: PrimaryAppBar(),
      body:
          state.status == LoadStatus.loading
              ? Center(child: CircularProgressIndicator(color: AppColors.blue))
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: resetTable,
                          icon: Icon(Icons.close, color: AppColors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            final errorMessage = validateTable();
                            if (errorMessage != null) {
                              PrimaryToast(message: errorMessage);
                            } else {
                              AppRouter.push(
                                AppRouter.orderConfirmation,
                                arguments: getTableData(),
                              );
                            }
                          },

                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    20.vertical,
                    RichText(
                      text: TextSpan(
                        text: AppStrings.order,
                        style: AppTextStyles.regular,
                        children: [
                          TextSpan(
                            text: '112096 ${AppStrings.allowEdit}',
                            style: AppTextStyles.regular.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.vertical,
                    //Table build
                    Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(color: AppColors.blue),
                        verticalInside: BorderSide(color: AppColors.blue),
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(0.8),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.quantity,
                                style: AppTextStyles.small,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.productName,
                                style: AppTextStyles.small,
                              ),
                            ),
                          ],
                        ),
                        for (int i = 0; i < quantityControllers.length; i++)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TableTextField(
                                  focusNode: quantityFocusNodes[i],
                                  controller: quantityControllers[i],
                                  onChanged: (_) => _checkAndAddRow(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onDoubleTap: () => _handleRowTap(i),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TableTextField(
                                          focusNode: productFocusNodes[i],
                                          suggestions:
                                              ref
                                                  .read(
                                                    orderNotifierProvider
                                                        .notifier,
                                                  )
                                                  .defaultProducts,
                                          textAlign: TextAlign.left,
                                          controller: productControllers[i],
                                          keyboardType: TextInputType.text,
                                          onChanged: (_) => _checkAndAddRow(),
                                        ),
                                      ),
                                      if (i < provider.products.length)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (provider
                                                    .products[i]
                                                    .notes
                                                    ?.isNotEmpty ??
                                                false)
                                              Icon(
                                                Icons.info,
                                                color: AppColors.blue,
                                                size: 20,
                                              ),
                                            if (provider
                                                    .products[i]
                                                    .imagePath !=
                                                null)
                                              Icon(
                                                Icons.camera_alt,
                                                color: AppColors.blue,
                                                size: 20,
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }

  void _addRows(int count) {
    final notifier = ref.read(orderNotifierProvider.notifier);
    for (int i = 0; i < count; i++) {
      quantityControllers.add(TextEditingController());
      productControllers.add(TextEditingController());
      quantityFocusNodes.add(FocusNode());
      productFocusNodes.add(FocusNode());

      if (i < notifier.products.length) {
        final product = notifier.products[i];
        productControllers[i].text = product.name;
        quantityControllers[i].text = product.quantity;
      }

      final index = quantityControllers.length - 1;
      productFocusNodes[index].addListener(() {
        if (productFocusNodes[index].hasFocus) {
          _handleProductFocus(index);
        }
      });
      quantityFocusNodes[index].addListener(() {
        if (quantityFocusNodes[index].hasFocus) {
          _handleQuantityFocus(index);
        }
      });
      productControllers[index].addListener(() {
        _updateProductModel(index);
      });
      quantityControllers[index].addListener(() {
        _updateProductModel(index);
      });
    }
  }

  void _updateProductModel(int index) {
    final notifier = ref.read(orderNotifierProvider.notifier);
    final currentProducts = notifier.products;
    final name = productControllers[index].text;
    final quantity = quantityControllers[index].text;
    if (name.isEmpty && quantity.isEmpty) return;
    if (index < currentProducts.length) {
      notifier.updateProduct(
        index,
        currentProducts[index].copyWith(name: name, quantity: quantity),
      );
    } else {
      notifier.addProduct(ProductModel(name: name, quantity: quantity));
    }
  }

  //Open dialog for image and notes
  void _handleRowTap(int index) {
    if (productControllers[index].text.isEmpty) return;
    final notifier = ref.read(orderNotifierProvider.notifier);
    final currentProducts = notifier.products;
    ProductModel product;
    if (index < currentProducts.length) {
      product = currentProducts[index].copyWith(
        name: productControllers[index].text,
        quantity: quantityControllers[index].text,
      );
    } else {
      product = ProductModel(
        name: productControllers[index].text,
        quantity: quantityControllers[index].text,
      );
    }
    EditProductSheet(initialProduct: product, index: index).show(context);
  }

  //Cant let user to go next field without filling the previous one
  void _handleProductFocus(int focusedIndex) {
    for (int i = 0; i < focusedIndex; i++) {
      if (productControllers[i].text.isEmpty ||
          quantityControllers[i].text.isEmpty) {
        if (productControllers[i].text.isEmpty) {
          FocusScope.of(context).requestFocus(productFocusNodes[i]);
        } else {
          FocusScope.of(context).requestFocus(quantityFocusNodes[i]);
        }
        return;
      }
    }
  }

  void _handleQuantityFocus(int focusedIndex) {
    for (int i = 0; i < focusedIndex; i++) {
      if (quantityControllers[i].text.isEmpty ||
          productControllers[i].text.isEmpty) {
        if (quantityControllers[i].text.isEmpty) {
          FocusScope.of(context).requestFocus(quantityFocusNodes[i]);
        } else {
          FocusScope.of(context).requestFocus(productFocusNodes[i]);
        }
        return;
      }
    }
  }

  //Reset the table using the cross icon on top
  resetTable() {
    for (var item in quantityControllers) {
      item.clear();
    }
    for (var item in productControllers) {
      item.clear();
    }
    ref.watch(orderNotifierProvider.notifier).products.clear();
    ref.watch(orderNotifierProvider).data = null;
    setState(() {});
  }

  //When all rows are filled then we are adding one more row automatically
  void _checkAndAddRow() {
    setState(() {});
    bool allFilled = true;
    for (int i = 0; i < quantityControllers.length; i++) {
      if (quantityControllers[i].text.isEmpty ||
          productControllers[i].text.isEmpty) {
        allFilled = false;
        break;
      }
    }
    if (allFilled) {
      setState(() => _addRows(1));
    }
  }

  //Dont let user go to next screen without filling at least on complete row on table
  String? validateTable() {
    if (quantityControllers.isEmpty || productControllers.isEmpty) {
      return AppStrings.fillOneField;
    }
    for (int i = 0; i < quantityControllers.length; i++) {
      final hasQuantity = quantityControllers[i].text.isNotEmpty;
      final hasProduct = productControllers[i].text.isNotEmpty;
      if (hasQuantity != hasProduct) {
        return '${AppStrings.fillOneRow} ${i + 1}';
      }
    }
    for (int i = 0; i < quantityControllers.length; i++) {
      if (quantityControllers[i].text.isNotEmpty &&
          productControllers[i].text.isNotEmpty) {
        return null;
      }
    }

    return AppStrings.fillOneField;
  }

  //Filtering the data
  List<ProductModel> getTableData() {
    final notifier = ref.read(orderNotifierProvider.notifier);
    return notifier.products
        .where(
          (product) => product.name.isNotEmpty && product.quantity.isNotEmpty,
        )
        .toList();
  }
}
