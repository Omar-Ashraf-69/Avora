import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chat/data/enums/message_status.dart';
import 'package:avora/features/chat/data/models/chat_message_model.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_Input.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_room_app_bar.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:avora/features/chat/presentation/views/widgets/scroll_down_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({
    super.key,
  required this.conversationId,
    this.userImage =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfMoUD1O9jVxSKrF3EFoS1k55PyUrojQ5Py3z-1oKQ95qlm0ozgY3YCpLl-UUkFf9D9fUjcCZyRVy5ls9GcUtzK9O2X9W1TCZmgmWFcxEUA&s=10",
    this.isOnline = false,
    this.lastSeen,
  });

  final String conversationId;
  final String? userImage;
  final bool isOnline;
  final String? lastSeen;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  static const _scrollThreshold = 100.0;

  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: ChatRoomAppBar(context: context, widget: widget),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.medium,
                      vertical: AppPadding.medium,
                    ),
                    itemCount: messages.length,
                    reverse: true,
                    separatorBuilder: (_, _) => verticalSpace(8),
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];

                      return MessageBubble(message: message);
                    },
                  ),
                  ScrollDownFloatingActionButton(
                    onPressed: _scrollToBottom,
                    showScrollToBottomButton: _showScrollToBottomButton,
                  ),
                ],
              ),
            ),
            ChatInput(
              controller: _messageController,
              onSend: _sendMessage,
              onImagePressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // With reverse:true, position 0 is the bottom.
    final shouldShowButton = _scrollController.offset > _scrollThreshold;

    if (shouldShowButton == _showScrollToBottomButton) return;

    setState(() {
      _showScrollToBottomButton = shouldShowButton;
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          text: text,
          createdAt: DateTime.now().toUtc(),
          isMe: true,
          status: MessageStatus.delivered,
        ),
      );
    });

    _messageController.clear();
    // With reverse:true, bottom = 0.
    _scrollToBottom();
  }
}
