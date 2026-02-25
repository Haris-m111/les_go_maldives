import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/views/drawer/delete_splash_screen.dart';

// This screen allows the user to permanently delete their account
// User must enter their password to confirm deletion
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
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
                        'Delete Account',
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
              // Warning Title Section
              // Warning section: shows a warning icon and title
              Row(
                children: [
                  Image.asset(
                    AppAssets.warningIcon,
                    width: 23.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Delete your account will:',
                      style: TextStyle(
                        fontFamily: AppFonts.raleway,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF369CAC),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      // Warning description
                      SizedBox(height: 12.h),
                      // Warning description explaining what happens after deletion
                      Text(
                        "We're sorry to see you go. If you're sure you want to delete your [App] account, please be aware that this action is permanent and cannot be undone. All of your personal information, including your Name and settings, will be permanently deleted.\n\nIf you're having trouble with your account or have concerns, please reach out to us at [contact email or support page] before proceeding with the account deletion. We'd love to help you resolve any issues and keep you as a valued [app] user.",
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 14.sp,
                          color: const Color(0xFF343434),
                          height: 1.5.h,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(height: 12.h),
                      // Password field to confirm account deletion
                      CustomTextField(
                        hintText: 'Enter Password',
                        prefixImagePath: AppAssets.pIcon,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                // Delete button navigates to the delete confirmation splash screen
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteSplashScreen(),
                      ),
                    );
                  },
                  child: const RoundButton(
                    title: 'Delete',
                    gradientColors: [
                      AppColors.gradientStart,
                      AppColors.gradientEnd,
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
}
