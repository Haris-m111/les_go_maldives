import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../fonts/app_fonts.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final Color? color;
  final Color? textColor;
  final List<Color>? gradientColors;

  const RoundButton({
    super.key,
    required this.title,
    this.loading = false,
    this.color,
    this.textColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.r),
        gradient: gradientColors != null && color == null
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
      ),
      child: Center(
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.raleway,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}
