import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';

class AppTextStyles {
  // Onboarding
  static TextStyle kamanaHere = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w700,
    fontSize: 34.sp,
    color: Colors.black, // FIXED: HEADING BLACK
  );

  static TextStyle onboardingDesc = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.darkCyan, // Description color
  );

  // Auth Basic
  static TextStyle authHeading = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: Colors.black, // FIXED: HEADING BLACK
  );

  static TextStyle authSubHeading = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.lightGrey,
  );

  static TextStyle inputField = TextStyle(
    fontFamily: AppFonts.raleway,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle inputHint = TextStyle(
    fontFamily: AppFonts.raleway,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.iconColor,
  );

  static TextStyle buttonText = TextStyle(
    fontFamily: AppFonts.raleway,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle smallText = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.black,
  );

  static TextStyle normalText = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black,
  );

  static TextStyle linkText = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: AppColors.primaryTextColor,
  );

  // OTP
  static TextStyle timerText = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: AppColors.inputBorder,
  );

  static TextStyle sendAgain = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.sendAgainColor,
  );

  // Popup
  static TextStyle popupHeading = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: AppColors.primaryBoxColor,
  );

  static TextStyle popupDesc = TextStyle(
    fontFamily: AppFonts.raleway,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.lightGrey,
  );
}
