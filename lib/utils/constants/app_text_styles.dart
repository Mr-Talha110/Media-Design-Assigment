import 'package:flutter/widgets.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_fonts.dart';

class AppTextStyles {
  static const TextStyle regular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.psBold,
    color: AppColors.purple,
  );
  static const TextStyle regularSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.psMedium,
    color: AppColors.black,
  );
  static const TextStyle small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blue,
    fontFamily: AppFonts.psMedium,
  );
  static const TextStyle medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.psBold,
  );
  static const TextStyle smallBody = TextStyle(
    fontSize: 8,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.psMedium,
  );
  static const TextStyle mediumBody = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.psMedium,
  );
}
