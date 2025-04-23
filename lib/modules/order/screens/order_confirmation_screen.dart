import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/screens/components/order_info_item.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';
import 'package:media_design_assingment_app/utils/extensions/space_extension.dart';
import 'package:media_design_assingment_app/utils/helping_methods/helping_methods.dart';
import 'package:media_design_assingment_app/utils/routes/app_router.dart';
import 'package:media_design_assingment_app/widgets/primary_appbar.dart';
import 'package:media_design_assingment_app/widgets/primary_button.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  //Calculate the total quantity of products
  String getTotalQuantity(List<ProductModel> products) {
    int total = 0;
    for (var product in products) {
      total = total + int.parse(product.quantity);
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products =
        ModalRoute.of(context)?.settings.arguments as List<ProductModel>;
    String orderNo = '112096';
    return Scaffold(
      appBar: PrimaryAppBar(hideDrawer: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: AppRouter.pop,
                icon: Icon(Icons.arrow_back, color: AppColors.blue),
              ),
            ),
            50.vertical,
            OrderInfoItem(title: AppStrings.order, subTitle: orderNo),
            OrderInfoItem(
              title: AppStrings.orderName,
              subTitle: 'Joe\'s catering',
              showOptionalMsg: true,
            ),
            OrderInfoItem(
              title: AppStrings.deliveryDate,
              subTitle: formatDate(DateTime.now()),
            ),
            OrderInfoItem(
              title: AppStrings.totalQuantity,
              subTitle: getTotalQuantity(products),
              subTitleStyle: AppTextStyles.regularSubtitle,
            ),
            OrderInfoItem(
              title: AppStrings.esimatedTotal,
              subTitle: '\$1402.96',
              subTitleStyle: AppTextStyles.regularSubtitle,
            ),
            OrderInfoItem(
              title: AppStrings.location,
              showDeliverToMsg: true,
              subTitle: '355 onderdonk st\nMarina Dubai, UAE',
              titleStyle: AppTextStyles.regular,
              subTitleStyle: AppTextStyles.regularSubtitle,
            ),
            Text(
              AppStrings.deliveryLocation,
              style: AppTextStyles.medium.copyWith(color: AppColors.blue),
            ),
            20.vertical,
            PrimaryButton(
              text: AppStrings.submit,
              onPressed:
                  () => AppRouter.push(
                    AppRouter.orderPreview,
                    arguments: [orderNo, products],
                  ),
            ),
            20.vertical,
            Text(
              AppStrings.saveAsDraft,
              style: AppTextStyles.medium.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
