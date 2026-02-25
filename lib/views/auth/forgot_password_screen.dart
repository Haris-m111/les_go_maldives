import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/views/auth/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // 1. FULL BACKGROUND COLOR
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primaryBoxColor,
            ),
            // 2. BACK BUTTON
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
            // 3. TOP IMAGE (Specific Dimensions: 169x274, Top: 50, Left: 131)
            Positioned(
              top: 50.h,
              left: 131.w,
              child: Image.asset(
                AppAssets.girl1,
                height: 274.h,
                width: 169.w,
                fit: BoxFit.contain,
              ),
            ),
            // 4. BOTTOM BOX (Top: 324, Radius: 32)
            Positioned(
              top: 324.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
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
                              'Forgot Password',
                              style: AppTextStyles.authHeading,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Kindly verify your email to forget your password.',
                              style: AppTextStyles.authSubHeading,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Enter Email Address',
                              prefixImagePath: AppAssets.eIcon,
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OTPScreen(isForgotPassword: true),
                            ),
                          );
                        },
                        child: const RoundButton(
                          title: 'Confirm',
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
