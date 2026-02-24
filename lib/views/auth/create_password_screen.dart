import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/views/auth/sign_in_screen.dart';

import 'package:les_go_maldives/res/components/success_popup.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  void _showSuccessPopup() {
    final navigator = Navigator.of(context);

    // Auto navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
        );
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'Password Created',
          description:
              'Sed dignissim nisl a vehicula fringilla. Nulla faucibus dui tellus, ut dignissim',
          onTap: () {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // FULL BACKGROUND COLOR
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primaryBoxColor,
            ),
            // BACK BUTTON
            Positioned(
              top: 73.h,
              left: 20.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  AppAssets.backIcon,
                  width: 44.w,
                  height: 44.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // First Box (Top) Image - Using girl2 as placeholder
            Positioned(
              top: 50.h,
              left: 121.w,
              child: Image.asset(
                AppAssets.girl2,
                height: 274.h,
                width: 188.w,
                fit: BoxFit.contain,
              ),
            ),
            // Second Box (Bottom)
            Positioned(
              top: 324.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create New Password',
                              style: AppTextStyles.authHeading,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Create your strong password, use it while login.',
                              style: AppTextStyles.authSubHeading,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Create Password',
                              prefixImagePath: AppAssets.pIcon,
                              isPassword: true,
                            ),
                            SizedBox(height: 15.h),
                            CustomTextField(
                              hintText: 'Confirm Password',
                              prefixImagePath: AppAssets.pIcon,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 32.h,
                      ),
                      child: GestureDetector(
                        onTap: _showSuccessPopup,
                        child: const RoundButton(
                          title: 'Create',
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
          ],
        ),
      ),
    );
  }
}
