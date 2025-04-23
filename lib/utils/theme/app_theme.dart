import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/utils/constants/app_colors.dart';
import 'package:media_design_assingment_app/utils/constants/app_fonts.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: AppColors.white,
  textTheme: const TextTheme().apply(
    displayColor: AppColors.black,
    fontFamily: AppFonts.psRegular,
  ),
);
