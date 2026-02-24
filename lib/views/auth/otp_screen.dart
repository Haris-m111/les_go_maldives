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

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isOtpFilled = false;

  void _showSuccessPopup() {
    // Pre-fetch navigator to avoid using context across async gaps
    final navigator = Navigator.of(context);

    // Auto navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
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
                builder: (context) => const CreateProfileScreen(),
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
    // UPDATED OTP DIGIT STYLE AS REQUESTED
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 48.h,
      textStyle: TextStyle(
        fontFamily: AppFonts.raleway, // Using project font
        fontSize: 16.sp,
        fontWeight: FontWeight.w400, // Weight 400
        color: const Color(0xFF629198), // Color 629198
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF), // Explicitly set as requested
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1.w),
      ),
      padding: EdgeInsets.zero,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        // keyboard pushes button up
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // 1. FULL BACKGROUND COLOR
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primaryBoxColor,
            ),
            // 2. BACK BUTTON (Using icons folder pic as requested)
            Positioned(
              top: 73.h,
              left: 20.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Image.asset(
                      AppAssets.backIcon, // assets/icons/backicon.png
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // 3. TOP IMAGE
            Positioned(
              top: 50.h,
              left: 121.w,
              child: Image.asset(
                AppAssets.girl3,
                height: 234.h,
                width: 205.w,
                fit: BoxFit.contain,
              ),
            ),
            // 4. BOTTOM BOX
            Positioned(
              top: 284.h,
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
                          vertical: 32.h,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
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
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            // OTP BOXES ALIGNMENT AND STYLE
                            Pinput(
                              length: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              separatorBuilder: (index) =>
                                  SizedBox(width: 14.w),
                              defaultPinTheme: defaultPinTheme,
                              preFilledWidget: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF629198),
                                ),
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!
                                    .copyWith(
                                      border: Border.all(
                                        color: const Color(0xFFC8C8C8),
                                      ),
                                    ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isOtpFilled = value.length == 5;
                                });
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              '00.54',
                              style: AppTextStyles.timerText.copyWith(
                                color: const Color(0xFF369CAC),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text('Send Again', style: AppTextStyles.sendAgain),
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
      ),
    );
  }
}
