import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_fonts.dart';
import 'package:les_go_maldives/res/components/success_popup.dart';

// This screen shows the user's full chat history list
// Each item has a 3-dot menu to delete that chat
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Shows a success popup after history item is deleted
  void _showDeletedPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SuccessPopup(
          imagePath: AppAssets.popupPic,
          title: 'History Deleted',
          description: 'Your search history has been successfully cleared.',
          onTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Shows a custom floating delete menu at the tapped position
  void _showDeleteMenu(BuildContext context, Offset tapPosition) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent, // No dark overlay behind the popup
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

    // If 'delete' was selected, show the deleted popup
    if (result == 'delete' && context.mounted) {
      _showDeletedPopup(context);
    }
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
                        'History',
                        style: TextStyle(
                          fontFamily: AppFonts.raleway,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44.w),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
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
                      context,
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

  // Reusable widget for each history list item
  Widget _buildHistoryItem(BuildContext context, String title) {
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
          Image.asset(AppAssets.msg3, width: 30.w, height: 30.h),
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
            // Capture exact tap position to show menu near the icon
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
