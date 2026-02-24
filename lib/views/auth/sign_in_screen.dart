import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/views/auth/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          // FULL BACKGROUND COLOR
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.primaryBoxColor,
          ),
          // First Box (Top) Image
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back!', style: AppTextStyles.authHeading),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to your account to access app features.',
                      style: AppTextStyles.authSubHeading,
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      hintText: 'Enter Email Address',
                      prefixImagePath: AppAssets.eIcon,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: 'Enter Password',
                      prefixImagePath: AppAssets.pIcon,
                      isPassword: true,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to Forgot Password screen
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontFamily: AppFonts.raleway,
                            fontWeight: FontWeight.w500, // Medium
                            fontSize: 16.sp,
                            color: const Color(0xFF369CAC),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement Sign In logic
                      },
                      child: const RoundButton(
                        title: 'Sign In',
                        gradientColors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                    ),
                    SizedBox(height: 90.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.leftLine, width: 100.w),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            'Or Continue',
                            style: AppTextStyles.smallText,
                          ),
                        ),
                        Image.asset(AppAssets.rightLine, width: 100.w),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          AppAssets.googleBox,
                          width: 80.w,
                          height: 48.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppTextStyles.normalText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text('Sign Up', style: AppTextStyles.linkText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
