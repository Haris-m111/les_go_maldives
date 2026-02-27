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
      // Background color jo top par nazar aayega
      backgroundColor: AppColors.primaryBoxColor,
      // Isay true rakhna zaroori hai taake box keyboard ke liye jagah banaye
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 1. IMAGE SECTION (Ye apni jagah fix rahegi)
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Container(
              height: 274.h, // 324.h (box start) - 50.h (top) = 274.h
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppAssets.girl2,
                width: 188.w,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. SCROLLABLE CONTENT (Neeche wala box)
          Column(
            children: [
              // Ye transparent box image ke upar space banayega
              SizedBox(height: 324.h),

              // Expanded box ko baki screen cover karne deta hai
              Expanded(
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.bgColor, // White background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    // Iske andar sirf box ka content scroll hoga
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 32.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'START WITH KAMANA',
                          style: AppTextStyles.authHeading,
                        ),
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

                        SizedBox(height: 100.h), // Spacing for "Or Continue"

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

                        SizedBox(height: 10.h),
                        Center(
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

                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: AppTextStyles.normalText,
                            ),
                            SizedBox(width: 6.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: AppTextStyles.linkText,
                              ),
                            ),
                          ],
                        ),
                        // Keyboard khulne par aakhri element ke neeche thodi space
                        // SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
