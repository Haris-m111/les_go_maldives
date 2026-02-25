import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/views/auth/sign_up_screen.dart';
import 'package:les_go_maldives/views/auth/sign_in_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          // 1. FULL BACKGROUND COLOR (Crucial for seeing rounded corners)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.primaryBoxColor,
          ),

          // 2. TOP IMAGE
          Positioned(
            top: 57.h,
            left: 79.w,
            child: Image.asset(
              AppAssets.girl1,
              height: 458.h,
              width: 272.w,
              fit: BoxFit.contain,
            ),
          ),

          // 3. BOTTOM BOX
          Positioned(
            top: 515.h, // EXACT TOP AS REQUESTED
            left: 0,
            right: 0,
            bottom: 0, // Fill the bottom
            child: Container(
              // Removed fixed height to ensure it fits content and fills bottom
              clipBehavior: Clip.antiAlias, // Clip children to rounded corners
              decoration: BoxDecoration(
                color: AppColors
                    .bgColor, // Changed to pure bgcolor for better visibility
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('KAMANA Here', style: AppTextStyles.kamanaHere),
                    SizedBox(height: 10.h),
                    Text(
                      'Your local Maldivian expert for everything\nin the Maldives.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.onboardingDesc.copyWith(
                        color: AppColors.lightGrey,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const RoundButton(
                        title: 'Sign Up with Email',
                        gradientColors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                    SizedBox(height: 30.h),
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
