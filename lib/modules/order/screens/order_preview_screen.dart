import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/modules/order/screens/components/order_preview_item.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/extensions/space_extension.dart';
import 'package:media_design_assingment_app/utils/routes/app_router.dart';
import 'package:media_design_assingment_app/widgets/primary_appbar.dart';

class OrderPreviewScreen extends StatelessWidget {
  const OrderPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List;
    final String orderNumber = args[0];
    final List<ProductModel> products = args[1] as List<ProductModel>;
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
            30.vertical,
            Text(
              '${AppStrings.order}$orderNumber',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            16.vertical,
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => 16.vertical,
                itemBuilder:
                    (context, index) =>
                        OrderPreviewItem(index: index, item: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
