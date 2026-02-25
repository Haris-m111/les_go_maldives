import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/components/custom_drawer.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';
import 'package:les_go_maldives/views/drawer/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isHistoryLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isHistoryLoading = false;
        });
      }
    });
  }

  void _showDeletedPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'History Deleted',
          description: 'Your search history has been successfully cleared.',
          onTap: () {
            Navigator.pop(context); // Close popup
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgColor,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Top Section (Header + Banner + Action Boxes + History Header)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Drawer Icon (Left)
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Image.asset(
                          AppAssets.drawerIcon,
                          width: 46.w,
                          height: 46.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // LGM Image (Right)
                      Image.asset(
                        AppAssets.lgmImage,
                        width: 44.w,
                        height: 44.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  // 3. KAMANA Banner
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Gradient Box
                      Container(
                        width: 390.w,
                        height: 134.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF369CAC), Color(0xFF096E7E)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20.w, 18.h, 120.w, 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KAMANA',
                              style: TextStyle(
                                fontFamily: AppFonts.raleway,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFBFCFF),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Your Maldivian concierge by Let’s Go Maldives — helping you find the right resort and book with confidence.',
                              style: TextStyle(
                                fontFamily: AppFonts.raleway,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFEFEFEF),
                                height: 1.5.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Overlapping Image
                      Positioned(
                        top: -25.h,
                        right: -4.w,
                        child: Image.asset(
                          AppAssets.girl1,
                          width: 130.w,
                          height: 159.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  // 4. Action Boxes Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionBox(
                        title: 'Talk to \nKamana',
                        description: 'Local help, anytime',
                        leftIcon: AppAssets.msg1,
                        rightIcon: AppAssets.arrow,
                      ),
                      _buildActionBox(
                        title: "TODAY'S BEST \nDEAL",
                        description: 'Picked just for you',
                        leftIcon: AppAssets.msg2,
                        rightIcon: AppAssets.arrow,
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  // 5. History Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'History',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      if (!_isHistoryLoading)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HistoryScreen(),
                              ),
                            );
                          },
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF369CAC), Color(0xFF096E7E)],
                            ).createShader(bounds),
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontFamily: AppFonts.raleway,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            // 6. History Content (Scrollable)
            if (_isHistoryLoading)
              Expanded(
                child: Center(
                  child: Image.asset(
                    AppAssets.homeLogo,
                    width: 260.w,
                    height: 205.h,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  itemCount: 14,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final titles = [
                      'Maldives Honeymoon Planning',
                      'Looking for luxury Maldives resort',
                      'Help me Book a Maldives Trip',
                      'Which Maldives resort suite Us',
                      'Planning a family vacation',
                      'Best water villas in Maldives',
                      'Budget friendly island resorts',
                      'Scuba diving spots in Maldives',
                    ];
                    return _buildHistoryItem(
                      index,
                      titles[index % titles.length],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBox({
    required String title,
    required String description,
    required String leftIcon,
    required String rightIcon,
  }) {
    return Container(
      width: 186.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: AppFonts.raleway,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1E1E),
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              fontFamily: AppFonts.raleway,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF757575),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(leftIcon, width: 34.w, height: 34.h),
              Image.asset(rightIcon, width: 14.w, height: 14.h),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteMenu(BuildContext context, Offset tapPosition) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (ctx) => Stack(
        children: [
          Positioned(
            left: 253.w,
            top: tapPosition.dy - 10.h,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 145.w,
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFC8C8C8), width: 1),
                ),
                child: GestureDetector(
                  onTap: () => Navigator.pop(ctx, 'delete'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppAssets.delIcon, width: 18.w, height: 18.h),
                      SizedBox(width: 8.w),
                      Text(
                        'Delete chat',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    if (result == 'delete' && mounted) {
      _showDeletedPopup();
    }
  }

  Widget _buildHistoryItem(int index, String title) {
    return Container(
      width: double.infinity,
      height: 58.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1.w),
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.msg3, width: 34.w, height: 34.h),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.raleway,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E1E1E),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTapDown: (details) {
              _showDeleteMenu(context, details.globalPosition);
            },
            child: Icon(Icons.more_vert, size: 24.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
