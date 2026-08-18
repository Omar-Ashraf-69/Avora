import 'package:avora/features/chat/presentation/views/widgets/custom_emoji_picker.dart';
import 'package:avora/features/chat/presentation/views/widgets/input_bar.dart';
import 'package:flutter/material.dart';

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
          InputBar(
            controller: widget.controller,
            focusNode: _focusNode,
            onFieldPressed: _onTextFieldTap,
            onEmojiPressed: _toggleEmojiPicker,
            onImagePressed: widget.onImagePressed,
            onSendPressed: widget.onSend,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: _showEmojiPicker
                ? CustomEmojiPicker(
                    controller: widget.controller,
                    emojiScrollController: _emojiScrollController,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
