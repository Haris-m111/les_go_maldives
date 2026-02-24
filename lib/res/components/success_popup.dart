import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';
import '../fonts/app_text_styles.dart';

class SuccessPopup extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const SuccessPopup({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Container(
          width: 350.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 150.h, fit: BoxFit.contain),
              SizedBox(height: 24.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.popupHeading.copyWith(
                  color: const Color(0xFF1E1E1E),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.popupDesc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
