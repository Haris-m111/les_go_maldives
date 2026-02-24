import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/views/auth/sign_in_screen.dart';

class DeleteSplashScreen extends StatefulWidget {
  const DeleteSplashScreen({super.key});

  @override
  State<DeleteSplashScreen> createState() => _DeleteSplashScreenState();
}

class _DeleteSplashScreenState extends State<DeleteSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.deleteSplashLogo,
                width: 100.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 12.h),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF369CAC), Color(0xFF096E7E)],
                ).createShader(bounds),
                child: Text(
                  'Account Deleted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.raleway,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white, // Color is overridden by ShaderMask
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'You are always welcomed back, please \ncome back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.raleway,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF343434),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
