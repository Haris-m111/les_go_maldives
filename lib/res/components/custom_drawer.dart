import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/views/drawer/about_app_screen.dart';
import 'package:les_go_maldives/views/drawer/delete_account_screen.dart';
import 'package:les_go_maldives/views/drawer/help_support_screen.dart';
import 'package:les_go_maldives/views/drawer/history_screen.dart';
import 'package:les_go_maldives/views/drawer/privacy_policy_screen.dart';
import 'package:les_go_maldives/views/drawer/terms_of_use_screen.dart';
import 'package:les_go_maldives/views/drawer/update_password_screen.dart';
import 'package:les_go_maldives/views/drawer/update_profile_screen.dart';
import 'package:les_go_maldives/views/auth/sign_in_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 370.w, // Increased width to accommodate icon partially outside
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Drawer Content
          Container(
            width: 346.w,
            height: 932.h,
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.r),
                bottomRight: Radius.circular(32.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h), // Top space
                // 1. Heading
                Text(
                  'Setting',
                  style: TextStyle(
                    fontFamily: AppFonts.raleway,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(height: 20.h),
                // 2. Profile Section
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        AppAssets.lgmImage,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sabrina Aryan',
                          style: TextStyle(
                            fontFamily: AppFonts.raleway,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF369CAC),
                          ),
                        ),
                        Text(
                          'California, USA',
                          style: TextStyle(
                            fontFamily: AppFonts.raleway,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // 3. Line
                Image.asset(AppAssets.lineImage, width: double.infinity),
                SizedBox(height: 22.h),
                // 4. Menu List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildDrawerItem(
                          icon: AppAssets.profileUpdateIcon,
                          title: 'Update profile',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateProfileScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.passwordChangeIcon,
                          title: 'Password Change',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UpdatePasswordScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.historyIcon,
                          title: 'History',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.aboutIcon,
                          title: 'About App',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutAppScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.helpIcon,
                          title: 'Help Support',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpSupportScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.privacyIcon,
                          title: 'Privacy Policy',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.privacyIcon,
                          title: 'Terms of Use',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TermsOfUseScreen(),
                              ),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          icon: AppAssets.deleteIcon,
                          title: 'Delete Account',
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DeleteAccountScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // 5. Gap and Line before Logout
                SizedBox(height: 10.h),
                Image.asset(AppAssets.lineImage, width: double.infinity),
                SizedBox(height: 20.h),
                // 6. Logout
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.logoutIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF343434),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          // Back Icon (Positioned slightly outside the drawer)
          Positioned(
            left: 320.w, // Drawer is 346w, so this overlaps the edge
            top: 124.h, // Near the profile section
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(AppAssets.iconBack, width: 44.w, height: 44.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(icon, width: 24.w, height: 26.h),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.raleway,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF343434),
                ),
              ),
            ),
            Image.asset(AppAssets.forwardIcon, width: 24.w, height: 24.h),
          ],
        ),
      ),
    );
  }
}
