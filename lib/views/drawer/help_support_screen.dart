import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h),
              // Header
              Row(
                children: [
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
                        'Help Center',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44.w),
                ],
              ),
              SizedBox(height: 33.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vestibulum sodales pulvinar accumsan raseing rhoncus neque',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF343434),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      _buildContactItem(
                        imagePath: AppAssets.chatUs,
                        title: 'Chat to us',
                        subtitle: 'abc@gmail.com',
                      ),
                      SizedBox(height: 20.h),
                      _buildContactItem(
                        imagePath: AppAssets.callUs,
                        title: 'Call us',
                        subtitle: '123457890',
                      ),
                      SizedBox(height: 20.h),
                      _buildContactItem(
                        imagePath: AppAssets.website,
                        title: 'Website',
                        subtitle: 'www.abc.com',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Image.asset(imagePath, width: 44.w, height: 44.h, fit: BoxFit.contain),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.raleway,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: AppFonts.raleway,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
