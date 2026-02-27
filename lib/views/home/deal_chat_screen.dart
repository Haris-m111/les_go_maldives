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

class _DealChatScreenState extends State<DealChatScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  // Controls whether the chat input mode is active or suggestion mode is visible
  bool _isChatActive = false;
  final TextEditingController _chatController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // Float animation for msg4
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Monitor text changes to update the send icon's color state
    _chatController.addListener(() {
      setState(() {
        _hasText = _chatController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
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
      // Enable keyboard resizing to allow content to scroll up
      resizeToAvoidBottomInset: true,
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
                // Suggestions List - Now vertically scrollable
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Always show the 4 suggestions as requested: "wo jo 4 han wohi show hon"
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
                        SizedBox(
                          height: _isChatActive ? 80.h : 180.h,
                        ), // Adjusted space for floating button or input bar
                      ],
                    ),
                  ),
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
                    setState(() {
                      _isChatActive = true;
                    });
                    // Request focus after the layout has updated to show the input bar
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _focusNode.requestFocus();
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Box - Animates Scale
                      AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _floatAnimation.value,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          AppAssets.box4,
                          width: 70.w,
                          height: 70.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Foreground Icon - Remains Fixed
                      Image.asset(
                        AppAssets.icon4,
                        width: 32.w, // Adjust size as needed
                        height: 32.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),

            // Persistent Chat Input Bar visible only when chat IS active
            if (_isChatActive)
              Positioned(
                bottom: 16.h,
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
                  color: const Color(0xFF629198),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                if (_hasText) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChattingScreen(),
                    ),
                  );
                }
              },
              child: _hasText
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
            ),
          ],
        ),
      ),
    );
  }
}
