import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/views/home/chatting_screen.dart';

/// Screen where users can see specific deal suggestions or activate a quick chat.
class DealChatScreen extends StatefulWidget {
  const DealChatScreen({super.key});

  @override
  State<DealChatScreen> createState() => _DealChatScreenState();
}

class _DealChatScreenState extends State<DealChatScreen> {
  // Controls whether the chat input mode is active or suggestion mode is visible
  bool _isChatActive = false;
  final TextEditingController _chatController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // Monitor text changes to update the send icon's color state
    _chatController.addListener(() {
      setState(() {
        _hasText = _chatController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Handles the back button click.
  /// If chat is active, it goes back to suggestion mode. Otherwise, it pops the screen.
  void _onBackTapped() {
    if (_isChatActive) {
      setState(() {
        _isChatActive = false;
      });
      _focusNode.unfocus();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // Prevents msg4/content from shifting poorly when keyboard opens.
      // Handled manually via viewInsets.bottom for the input bar.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // --- 1. Main Content area (Suggestions & Guide) ---
            Column(
              children: [
                // Top Header Section with Back Icon and Avatar
                SizedBox(
                  height: 280.h,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 50.h,
                        left: 20.w,
                        child: GestureDetector(
                          onTap: _onBackTapped,
                          child: Image.asset(
                            AppAssets.backIcon,
                            width: 46.w,
                            height: 46.h,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50.h,
                        child: Image.asset(
                          AppAssets.girl5,
                          width: 160.w,
                          height: 230.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                // Introductory Guide Text
                Text(
                  "What are you looking for today? I'll \nguide you",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.normalText.copyWith(
                    color: const Color(0xFF343434),
                  ),
                ),
                SizedBox(height: 20.h),
                // Suggestions List
                Column(
                  children: [
                    if (!_isChatActive) ...[
                      // Suggestion boxes that navigate directly to ChattingScreen
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChattingScreen(),
                          ),
                        ),
                        child: _buildSuggestionBox(
                          'Looking for luxury Madives resort',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildSuggestionBox('Plan a maldives honeymoon'),
                      SizedBox(height: 10.h),
                      _buildSuggestionBox('Help me Book a Maldives Trip'),
                      SizedBox(height: 10.h),
                      _buildSuggestionBox('Which Maldives resort suite Us?'),
                    ] else ...[
                      // Chat Mode specific suggestions
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChattingScreen(),
                          ),
                        ),
                        child: _buildSuggestionBox('Plan a maldives honeymoon'),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChattingScreen(),
                          ),
                        ),
                        child: _buildSuggestionBox(
                          'Looking for luxury Madives resort',
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),

            // --- 2. Floating Bottom Elements ---
            // Large message bubble icon (msg4) visible only when chat is NOT active
            if (!_isChatActive)
              Positioned(
                bottom: 30.h,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _isChatActive = true);
                    _focusNode.requestFocus();
                  },
                  child: Image.asset(
                    AppAssets.msg4,
                    width: 70.51.w,
                    height: 70.51.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

            // Persistent Chat Input Bar visible only when chat IS active
            if (_isChatActive)
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
                left: 0,
                right: 0,
                child: _buildChatInputBar(),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds a clickable suggestion box with text
  Widget _buildSuggestionBox(String text) {
    return Container(
      width: 270.w,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFC8C8C8), width: 1),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.smallText.copyWith(
            fontSize: 15.sp,
            color: const Color(0xFF777777),
          ),
        ),
      ),
    );
  }

  /// Builds the chat input bar tailored for DealChatScreen
  Widget _buildChatInputBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: const Color(0xFFC8C8C8), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppAssets.msg1,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _chatController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Ask me...',
                  hintStyle: AppTextStyles.inputHint.copyWith(
                    fontSize: 14.sp,
                    color: const Color(0xFFA1A1AA),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: AppTextStyles.inputField.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Send indicator with gradient color logic
            _hasText
                ? ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF369CAC), Color(0xFF096E7E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Icon(
                      Icons.send_rounded,
                      size: 24.sp,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.send_rounded,
                    size: 24.sp,
                    color: const Color(0xFFA1A1AA),
                  ),
          ],
        ),
      ),
    );
  }
}
