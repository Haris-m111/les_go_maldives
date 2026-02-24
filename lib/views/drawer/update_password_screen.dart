import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  void _showPasswordUpdatedPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'Password Updated',
          description:
              'Sed dignissim nisl a vehicula fringilla. Nulla faucibus dui tellus, ut dignissim',
          onTap: () {
            Navigator.pop(context); // Close popup
            Navigator.pop(context); // Go back from screen
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
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
                        'Update password',
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
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You can update your password here.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: AppFonts.raleway,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF343434),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      // Form
                      CustomTextField(
                        hintText: 'Current Password',
                        prefixImagePath: AppAssets.pIcon,
                        isPassword: true,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        hintText: 'Create New Password',
                        prefixImagePath: AppAssets.pIcon,
                        isPassword: true,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        hintText: 'Confirm New Password',
                        prefixImagePath: AppAssets.pIcon,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  onTap: _showPasswordUpdatedPopup,
                  child: const RoundButton(
                    title: 'Update',
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
