import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/components/round_button.dart';
import 'package:les_go_maldives/res/components/custom_text_field.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';

// This screen allows the user to update their profile information
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Shows a popup when profile is successfully updated
  void _showProfileUpdatedPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'Profile Updated',
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
                        'Update profile',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44.w), // Balance for back button
                ],
              ),
              SizedBox(height: 33.h),
              // Short description text below the header
              Text(
                'Set your profile by providing following information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.raleway,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF343434),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      // Profile Image Section
                      // Circular profile image with camera icon for changing photo
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 105.w,
                              height: 105.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(AppAssets.lgmImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: -5,
                              // Camera icon to let user pick a new profile picture
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                child: Image.asset(
                                  AppAssets.cameraIcon,
                                  width: 26.w,
                                  height: 26.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Form fields for name and Telegram username
                      CustomTextField(
                        hintText: 'Enter name',
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
                padding: EdgeInsets.symmetric(vertical: 20.h),
                // Update button triggers the success popup
                child: GestureDetector(
                  onTap: _showProfileUpdatedPopup,
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
