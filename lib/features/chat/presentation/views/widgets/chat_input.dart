
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onImagePressed,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onImagePressed;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> with WidgetsBindingObserver {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _emojiScrollController = ScrollController();

  bool _showEmojiPicker = false;
  bool _keyboardWasVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;

    final keyboardVisible = bottomInset > 0;

    if (keyboardVisible && !_keyboardWasVisible) {
      // Native keyboard was opened.
      if (_showEmojiPicker) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    }

    _keyboardWasVisible = keyboardVisible;
  }

  Future<void> _toggleEmojiPicker() async {
    // Emoji picker is currently open.
    if (_showEmojiPicker) {
      setState(() {
        _showEmojiPicker = false;
      });

      // Let the UI update before requesting the keyboard.
      await Future.delayed(const Duration(milliseconds: 50));

      if (!mounted) return;

      _focusNode.requestFocus();
      return;
    }

    // Keyboard is currently open.
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();

      // Give Flutter/Android time to dismiss the keyboard.
      await Future.delayed(const Duration(milliseconds: 150));

      if (!mounted) return;
    }

    setState(() {
      _showEmojiPicker = true;
    });
  }

  void _onTextFieldTap() {
    if (_showEmojiPicker) {
      setState(() {
        _showEmojiPicker = false;
      });
    }

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _focusNode.dispose();
    _emojiScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_showEmojiPicker,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        setState(() {
          _showEmojiPicker = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInputBar(),

          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: _showEmojiPicker
                ? _buildEmojiPicker()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onTap: _onTextFieldTap,
              minLines: 1,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyles.regular15.copyWith(
                  color: AppColors.lightGray,
                ),

                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: _toggleEmojiPicker,
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.only(left: AppPadding.small),
                        child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: AppColors.mainBlue,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: widget.onImagePressed,
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.small,
                        ),
                        child: Icon(
                          Icons.image_outlined,
                          color: AppColors.mainBlue,
                        ),
                      ),
                    ),
                  ],
                ),

                filled: true,
                fillColor: AppColors.lightWhite,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: AppColors.mainBlue,
                    width: .8,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Material(
            color: AppColors.mainBlue,
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: widget.onSend,
              icon: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 300.h,
      child: EmojiPicker(
        textEditingController: widget.controller,
        scrollController: _emojiScrollController,
        config: Config(
          height: 300.h,

          checkPlatformCompatibility: true,

          viewOrderConfig: const ViewOrderConfig(),

          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax:
                28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),

          skinToneConfig: const SkinToneConfig(rememberSkinTone: true),

          categoryViewConfig: const CategoryViewConfig(),

          bottomActionBarConfig: const BottomActionBarConfig(),

          searchViewConfig: const SearchViewConfig(),
        ),
      ),
    );
  }
}
