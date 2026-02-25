import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';

// This screen shows information about the app
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder text describing the app
    const String aboutText =
        'Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Maliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. \n\nAenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Maliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. \n\nAenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Maliquet. Morbi eget purus nulla. Aenean viverra ex ac enim hendrerit aliquet. Morbi eget purus nulla.';

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          // Horizontal padding for consistent screen spacing
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 45.h),
              // Header
              Row(
                children: [
                  // Back icon to go back to previous screen
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      AppAssets.backIcon,
                      width: 46.w,
                      height: 46.h,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'About App',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                  // Empty box to balance the back icon on the left
                  SizedBox(width: 44.w),
                ],
              ),
              SizedBox(height: 33.h),
              // Scrollable area for the about text
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    aboutText,
                    style: TextStyle(
                      fontFamily: AppFonts.raleway,
                      fontSize: 16.sp,
                      color: const Color(0xFF343434),
                      height: 1.5.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
