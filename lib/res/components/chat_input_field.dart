import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';

/// A reusable chat input component with a leading icon, text field, and send button.
class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final bool hasText;
  final String hintText;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.hasText,
    this.hintText = 'Ask me...',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            // Leading msg icon (message icon 1 from assets)
            Image.asset(
              AppAssets.msg1,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            // Text input field
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                style: AppTextStyles.inputField.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xFF1E1E1E),
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyles.inputHint.copyWith(
                    fontSize: 14.sp,
                    color: const Color(0xFFA1A1AA),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            // Send button with dynamic color based on existence of text
            GestureDetector(
              onTap: hasText ? onSend : null,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: hasText
                      ? [const Color(0xFF369CAC), const Color(0xFF096E7E)]
                      : [const Color(0xFFA1A1AA), const Color(0xFFA1A1AA)],
                ).createShader(bounds),
                child: const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
