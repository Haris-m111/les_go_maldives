import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';
import 'package:les_go_maldives/views/home/home_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  void _showProfileCreatedPopup() {
    final navigator = Navigator.of(context);

    // Auto navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'Profile Created',
          description:
              'Sed dignissim nisl a vehicula fringilla. Nulla faucibus dui tellus, ut dignissim',
          onTap: () {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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
            // 1. FULL BACKGROUND COLOR
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primaryBoxColor,
            ),
            // 2. TOP IMAGE
            Positioned(
              top: 60.h,
              left: 121.w,
              child: Image.asset(
                AppAssets.girl4,
                height: 234.h,
                width: 205.w,
                fit: BoxFit.contain,
              ),
            ),
            // 3. BOTTOM BOX
            Positioned(
              top: 294.h, // FIXED TOP AS REQUESTED
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
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
                                    "Let's set up your profile",
                                    style: TextStyle(
                                      fontFamily: AppFonts.raleway,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E1E1E),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Just a few details — so I can guide you better.',
                                    style: TextStyle(
                                      fontFamily: AppFonts.raleway,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF343434),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // PROFILE PICTURE BOX
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(AppAssets.lgmImage),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFC8C8C8),
                                        width: 1.w,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Image.asset(
                                      AppAssets.cameraIcon,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // TEXT FIELDS
                            CustomTextField(
                              hintText: 'Enter Name',
                              prefixImagePath: AppAssets.perIcon,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              hintText: 'Telegram',
                              prefixImagePath: AppAssets.calIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: GestureDetector(
                        onTap: _showProfileCreatedPopup,
                        child: const RoundButton(
                          title: 'Create Profile',
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
