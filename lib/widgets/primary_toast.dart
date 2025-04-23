import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/utils/app_settings.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';
import 'package:media_design_assingment_app/utils/routes/app_router.dart';
import 'package:toastification/toastification.dart';

class PrimaryToast extends StatelessWidget {
  PrimaryToast({super.key, required this.message}) {
    if (AppSettings.isToastShowing) return;
    AppSettings.showToast = true;
    toastification.showCustom(
      builder: (context, holder) {
        return this;
      },
      context: AppRouter.key.currentContext,
      callbacks: AppSettings.onToastCalls(),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.blue,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
