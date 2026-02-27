import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/app_colors.dart';
import '../fonts/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? prefixImagePath;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixImagePath,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: AppColors.inputBorder, width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          if (widget.prefixImagePath != null)
            Image.asset(
              widget.prefixImagePath!,
              height: 20.sp,
              width: 20.sp,
              color: AppColors.iconColor,
            )
          else if (widget.prefixIcon != null)
            Icon(widget.prefixIcon, color: AppColors.iconColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              obscureText: _obscureText,
              keyboardType: widget.keyboardType,
              style: AppTextStyles.inputField,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.inputHint,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (widget.isPassword)
            GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.iconColor,
                size: 20.sp,
              ),
            )
          else if (widget.suffixIcon != null)
            Icon(widget.suffixIcon, color: AppColors.iconColor, size: 20.sp),
        ],
      ),
    );
  }
}
