import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_strings.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';

class OrderInfoItem extends StatelessWidget {
  final String title;
  final bool showOptionalMsg;
  final bool showDeliverToMsg;
  final String subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  const OrderInfoItem({
    super.key,
    required this.title,
    required this.subTitle,
    this.subTitleStyle,
    this.titleStyle,
    this.showOptionalMsg = false,
    this.showDeliverToMsg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    titleStyle ??
                    AppTextStyles.medium.copyWith(color: AppColors.purple),
              ),
              Visibility(
                visible: showOptionalMsg,
                child: Text(
                  AppStrings.optional,
                  style: AppTextStyles.smallBody,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: showDeliverToMsg,
                child: Text(
                  AppStrings.deliverTo,
                  style: AppTextStyles.mediumBody,
                ),
              ),
              Text(
                subTitle,
                style:
                    subTitleStyle ??
                    AppTextStyles.regular.copyWith(color: AppColors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
