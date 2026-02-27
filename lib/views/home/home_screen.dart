import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/components/custom_drawer.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';
import 'package:les_go_maldives/views/drawer/history_screen.dart';
import 'package:les_go_maldives/views/home/chatting_screen.dart';
import 'package:les_go_maldives/views/home/deal_chat_screen.dart';

/// The main landing screen after login.
/// Includes a banner for Kamana, action boxes, and a chat history list.
class HomeScreen extends StatefulWidget {
  /// If true, the history list is shown immediately without the loading animation.
  final bool showHistoryImmediately;
  const HomeScreen({super.key, this.showHistoryImmediately = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isHistoryLoading =
      true; // State to handle the 2-second loading animation for history

  @override
  void initState() {
    super.initState();
    // Start history loading simulation unless showHistoryImmediately is true
    if (widget.showHistoryImmediately) {
      _isHistoryLoading = false;
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isHistoryLoading = false;
          });
        }
      });
    }
  }

  /// Displays the success popup after a history item is deleted.
  void _showDeletedPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
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
    return WillPopScope(
      onWillPop: () async {
        // Reliable move to background via MethodChannel to avoid splash on resume
        const platform = MethodChannel('com.example.app/background');
        try {
          await platform.invokeMethod('moveTaskToBack');
        } catch (e) {
          debugPrint("Failed to move to background: $e");
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.bgColor,
        drawer: const CustomDrawer(), // Custom side menu
        body: SafeArea(
          child: Column(
            children: [
              // --- TOP SECTION (Header + Banner + Action Boxes + History Header) ---
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: Column(
                  children: [
                    // App Header with Drawer Icon and Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Image.asset(
                          AppAssets.lgmImage,
                          width: 44.w,
                          height: 44.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // KAMANA Promo Banner
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
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
                                style: AppTextStyles.kamanaHere.copyWith(
                                  fontSize: 24.sp,
                                  color: const Color(0xFFFBFCFF),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Your Maldivian concierge by Let’s Go Maldives — helping you find the right resort and book with confidence.',
                                style: AppTextStyles.onboardingDesc.copyWith(
                                  fontSize: 14.sp,
                                  color: const Color(0xFFEFEFEF),
                                  height: 1.5.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Floating girl image overlapping the banner
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

                    // Action Boxes (Talk to Kamana & Today's Deal)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChattingScreen(),
                              ),
                            );
                          },
                          child: _buildActionBox(
                            title: 'Talk to \nKamana',
                            description: 'Local help, anytime',
                            leftIcon: AppAssets.msg1,
                            rightIcon: AppAssets.arrow,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DealChatScreen(),
                              ),
                            );
                          },
                          child: _buildActionBox(
                            title: "TODAY'S BEST \nDEAL",
                            description: 'Picked just for you',
                            leftIcon: AppAssets.msg2,
                            rightIcon: AppAssets.arrow,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'History',
                          style: AppTextStyles.authHeading.copyWith(
                            fontSize: 18.sp,
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
                                style: AppTextStyles.buttonText.copyWith(
                                  fontSize: 14.sp,
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

              // --- HISTORY CONTENT (Logo while loading, List after 2s) ---
              if (_isHistoryLoading)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.homeLogo,
                        width: 260.w,
                        height: 205.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'No History yet!',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                    itemCount: 14,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
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
      ),
    );
  }

  /// Helper to build the square action boxes (Talk to Kamana, etc.)
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
            style: AppTextStyles.authHeading.copyWith(
              fontSize: 20.sp,
              color: const Color(0xFF1E1E1E),
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: AppTextStyles.smallText.copyWith(
              fontSize: 12.sp,
              color: const Color(0xFF757575),
            ),
          ),
          SizedBox(height: 8.h),
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

  /// Shows the delete menu (3-dot popup) for a history item
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
                        style: AppTextStyles.buttonText.copyWith(
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

  /// Builds an individual history list item with tap-to-chat logic
  Widget _buildHistoryItem(int index, String title) {
    return Container(
      width: double.infinity,
      height: 58.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000), // 12% Opacity
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Navigate to ChattingScreen immediately, skipping generating delay
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChattingScreen(skipGenerating: true),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(AppAssets.msg3, width: 34.w, height: 34.h),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.normalText.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E1E1E),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 3-dot menu icon for deletion
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
