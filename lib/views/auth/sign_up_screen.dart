import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/views/auth/otp_screen.dart';
import 'package:les_go_maldives/views/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
            top: 50.h, // Image bottom at 515 (241 + 274 = 515)
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
            top: 324.h, // EXACT TOP AS REQUESTED
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.bgColor, // Pure white for better contrast
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
                    Text('START WITH KAMANA', style: AppTextStyles.authHeading),
                    SizedBox(height: 8.h),
                    Text(
                      "We'll set up your profile as you go.",
                      style: AppTextStyles.authSubHeading,
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      hintText: 'Enter Email Address',
                      prefixImagePath: AppAssets.eIcon,
                    ),
                    SizedBox(height: 15.h),
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
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OTPScreen(),
                          ),
                        );
                      },
                      child: const RoundButton(
                        title: 'Sign Up',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(5.w, 0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              AppAssets.googleBox,
                              width: 80.w,
                              height: 54.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(-5.w, 0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              AppAssets.appleBox,
                              width: 80.w,
                              height: 54.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTextStyles.normalText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          child: Text('Sign In', style: AppTextStyles.linkText),
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
