import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_fonts.dart';
import 'package:media_design_assingment_app/utils/constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final Color? textColor;
  final bool isLoading;
  final bool isDisable;
  final double? width;
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.textColor,
    this.margin,
    required this.text,
    this.radius,
    this.padding,
    this.bgColor,
    this.width,
    this.isLoading = false,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0.0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              side: BorderSide(
                color:
                    textColor == null ? AppColors.transparent : AppColors.grey,
              ),
            ),
          ),
          padding: WidgetStatePropertyAll(
            padding ?? const EdgeInsets.symmetric(vertical: 16),
          ),
          backgroundColor: WidgetStatePropertyAll(
            isDisable ? AppColors.grey : bgColor ?? AppColors.blue,
          ),
        ),
        onPressed: isDisable ? () {} : onPressed,
        child:
            isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2.5,
                  ),
                )
                : Text(
                  text,
                  style: AppTextStyles.regular.copyWith(
                    color: textColor ?? AppColors.white,
                    fontWeight: FontWeight.w300,
                    fontFamily: AppFonts.psLight,
                  ),
                ),
      ),
    );
  }
}
