import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:les_go_maldives/res/colors/app_colors.dart';
import 'package:les_go_maldives/res/constants/app_assets.dart';
import 'package:les_go_maldives/res/fonts/app_text_styles.dart';
import 'package:les_go_maldives/res/components/chat_input_field.dart';
import 'package:les_go_maldives/views/home/home_screen.dart';

/// Screen where users can chat with Kamana (AI assistant).
/// Handles initial message generation delay and displays chat history.
class ChattingScreen extends StatefulWidget {
  /// If true, the "Generating..." delay is skipped and all messages are shown immediately.
  final bool skipGenerating;
  const ChattingScreen({super.key, this.skipGenerating = false});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText =
      false; // Tracks if the input field has text to enable/disable send button

  bool _isGenerating = false; // Tracks if the AI is "generating" a response

  // Mock messages for display purposes
  final List<Map<String, dynamic>> _allMessages = [
    {
      'isMe': true,
      'sender': 'You',
      'text': 'Plan a maldives honeymoon.',
      'time': '8:50 PM',
    },
    {
      'isMe': false,
      'sender': 'Kamana',
      'text':
          'Congratulations on your honeymoon — the Maldives is a truly exquisite choice 🤍 I’ll curate this personally for you, step by step, so it’s seamless and perfectly matched to your style as a couple.\n\nTo begin shaping the ideal honeymoon, may I gently learn a little about your plans and preferences?\n\nFirst, your travel framework:\nDo you have fixed travel dates, or are you flexible?\nHow many nights are you hoping to stay in the Maldives?',
      'time': '8:52 PM',
    },
    {
      'isMe': true,
      'sender': 'You',
      'text': 'Plan a maldives honeymoon.',
      'time': '8:53 PM',
    },
    {
      'isMe': false,
      'sender': 'Kamana',
      'text':
          'Congratulations on your honeymoon — the Maldives is a truly exquisite choice 🤍 I’ll curate this personally for you, step by step, so it’s seamless and perfectly matched to your style as a couple.\n\nTo begin shaping the ideal honeymoon, may I gently learn a little about your plans and preferences?\n\nFirst, your travel framework:\nDo you have fixed travel dates, or are you flexible?\nHow many nights are you hoping to stay in the Maldives?',
      'time': '8:55 PM',
    },
  ];

  List<Map<String, dynamic>> _visibleMessages = [];

  @override
  void initState() {
    super.initState();

    // Determine initial visibility of messages based on the skipGenerating flag
    if (widget.skipGenerating) {
      _visibleMessages = _allMessages;
      _isGenerating = false;
    } else {
      // Show only the first message and the "Generating..." bubble initially
      _visibleMessages = [_allMessages[0]];
      _isGenerating = true;

      // Simulate a 2-second delay for AI response generation
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isGenerating = false;
            _visibleMessages = _allMessages;
          });
        }
      });
    }

    // Listen to text changes to update the send button color
    _messageController.addListener(() {
      setState(() {
        _hasText = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Custom AppBar Section ---
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 40.h,
                bottom: 10.h,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate back to HomeScreen and clear navigation stack
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(showHistoryImmediately: true),
                        ),
                        (route) => false,
                      );
                    },
                    child: Image.asset(
                      AppAssets.backIcon,
                      width: 46.w,
                      height: 46.h,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  // Kamana Avatar in AppBar
                  Container(
                    width: 38.w,
                    height: 38.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppAssets.girl6),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Kamana',
                    style: AppTextStyles.authHeading.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.primaryBoxColor,
                    ),
                  ),
                ],
              ),
            ),

            // --- Chat Messages List Section ---
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                    itemCount: _visibleMessages.length,
                    itemBuilder: (context, index) {
                      final msg = _visibleMessages[index];
                      return _buildMessageBubble(msg);
                    },
                  ),
                  // Floating "Generating..." bubble at the bottom of the list area
                  if (_isGenerating)
                    Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w, // Constraint for Flexible width
                      child: _buildMessageBubble({
                        'isMe': false,
                        'sender': 'Kamana',
                        'text': 'Generating...',
                        'time': '',
                      }),
                    ),
                ],
              ),
            ),

            // --- Bottom Input Field Component ---
            ChatInputField(
              controller: _messageController,
              focusNode: _focusNode,
              hasText: _hasText,
              onSend: () {
                // Future: Implement actual message sending logic
                _messageController.clear();
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  /// Builds an individual message bubble for either the user or Kamana.
  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    bool isMe = msg['isMe'];
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, // Align avatars to top
        children: [
          if (!isMe) ...[
            // Kamana Avatar for incoming messages
            Container(
              width: 32.w,
              height: 32.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppAssets.girl6),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],

          isMe
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width *
                        0.6, // Narrowed width
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0x33369CAC), // 20% opacity
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.zero, // Tail points to avatar
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                    ),
                    child: _buildBubbleContent(msg, isMe),
                  ),
                )
              : Flexible(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0x1A919EAB), // 10% opacity
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, // Tail points to avatar
                        topRight: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                    ),
                    child: _buildBubbleContent(msg, isMe),
                  ),
                ),

          if (isMe) ...[
            SizedBox(width: 8.w),
            // User Avatar for outgoing messages
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(AppAssets.lgmImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(19.69.r),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Internal layout of the message bubble (Sender, Text, Time).
  Widget _buildBubbleContent(Map<String, dynamic> msg, bool isMe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sender Name
        Text(
          msg['sender'],
          style: AppTextStyles.smallText.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
        ),
        SizedBox(height: 4.h),
        // Message Text
        Text(
          msg['text'],
          style: AppTextStyles.smallText.copyWith(
            color: const Color(0xFF1E1E1E),
          ),
        ),
        if (msg['time'].isNotEmpty) ...[
          SizedBox(height: 8.h),
          // Delivery Time
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              msg['time'],
              style: AppTextStyles.smallText.copyWith(
                fontSize: 10.sp,
                color: const Color(0xFF777777),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
