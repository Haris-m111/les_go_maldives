import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/views/auth/create_profile_screen.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';
import 'package:les_go_maldives/views/auth/create_password_screen.dart';

class OTPScreen extends StatefulWidget {
  final bool isForgotPassword;
  const OTPScreen({super.key, this.isForgotPassword = false});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isOtpFilled = false;

  void _showSuccessPopup() {
    final navigator = Navigator.of(context);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => widget.isForgotPassword
                ? const CreatePasswordScreen()
                : const CreateProfileScreen(),
          ),
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
          title: 'Email Verified',
          description:
              'Sed dignissim nisl a vehicula fringilla. Nulla faucibus dui tellus, ut dignissim',
          onTap: () {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => widget.isForgotPassword
                    ? const CreatePasswordScreen()
                    : const CreateProfileScreen(),
              ),
              (route) => false,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55.w, // Slightly increased for 430 width
      height: 55.h,
      textStyle: TextStyle(
        fontFamily: AppFonts.raleway,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF629198),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1.w),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBoxColor,
        resizeToAvoidBottomInset: true, // Key property
        body: Stack(
          children: [
            // 1. TOP IMAGE (Fixed Position)
            Positioned(
              top: 50.h,
              left: 0,
              right: 0,
              child: Container(
                height: 234.h, // Touches box at 284.h
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  AppAssets.girl3,
                  width: 205.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 2. BACK BUTTON
            Positioned(
              top: 65.h,
              left: 20.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  AppAssets.backIcon,
                  width: 44.w,
                  height: 44.h,
                ),
              ),
            ),

            // 3. MAIN CONTENT COLUMN
            Column(
              children: [
                SizedBox(height: 284.h), // Gap for girl image
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        // SCROLLABLE PART
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 32.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Check your email',
                                  style: AppTextStyles.authHeading,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'I’ve sent you a one-time code to verify it.',
                                  style: AppTextStyles.authSubHeading,
                                ),
                                SizedBox(height: 40.h),

                                // Pinput Field
                                Center(
                                  child: Pinput(
                                    length: 5,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    separatorBuilder: (index) =>
                                        SizedBox(width: 15.w),
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!
                                          .copyWith(
                                            border: Border.all(
                                              color: AppColors.gradientStart,
                                            ),
                                          ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        isOtpFilled = value.length == 5;
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(height: 25.h),

                                if (!isOtpFilled)
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          '00:54',
                                          style: AppTextStyles.timerText
                                              .copyWith(
                                                color: const Color(0xFF369CAC),
                                                fontSize: 20.sp,
                                              ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'Send Again',
                                          style: AppTextStyles.sendAgain,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // FIXED BUTTON AT BOTTOM (Keyboard ke upar move hoga)
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            bottom: 10.h, // Adjusted for 932 height
                            top: 10.h,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (isOtpFilled) {
                                _showSuccessPopup();
                              }
                            },
                            child: RoundButton(
                              title: 'Verify',
                              color: isOtpFilled
                                  ? null
                                  : AppColors.disabledButtonColor,
                              gradientColors: isOtpFilled
                                  ? const [
                                      AppColors.gradientStart,
                                      AppColors.gradientEnd,
                                    ]
                                  : null,
                              textColor: isOtpFilled
                                  ? Colors.white
                                  : AppColors.disabledTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
