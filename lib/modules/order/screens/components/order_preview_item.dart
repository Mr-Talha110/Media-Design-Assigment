import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/modules/order/models/product_model.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/extensions/opacity_extension.dart';
import 'package:media_design_assingment_app/utils/extensions/space_extension.dart';

class OrderPreviewItem extends StatelessWidget {
  final int index;
  final ProductModel item;
  const OrderPreviewItem({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grey.withCustomOpacity(0.1),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${index + 1}.'),
              10.horizontal,
              Visibility(
                visible: item.imagePath != null,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(item.imagePath ?? '')),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 50,
                  height: 50,
                ),
              ),
              Visibility(visible: item.imagePath != null, child: 8.horizontal),
              Text('${AppStrings.qty} ${item.name}'),
              Spacer(),
              Text('${AppStrings.qty} ${item.quantity}'),
            ],
          ),
          6.vertical,
          Visibility(
            visible: item.notes != null && item.notes!.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('${AppStrings.notes} ${item.notes ?? ''}'),
            ),
          ),
        ],
      ),
    );
  }
}
