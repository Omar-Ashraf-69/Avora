import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chat/data/enums/message_status.dart';
import 'package:avora/features/chat/data/models/chat_message_model.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_Input.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_room_app_bar.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({
    super.key,
    required this.userName,
    this.userImage,
    this.isOnline = false,
    this.lastSeen,
  });

  final String userName;
  final String? userImage;
  final bool isOnline;
  final String? lastSeen;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;
    //! Must edite the time of the message this is only for testing the UI
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

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuart,
      );
    });
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
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.medium,
                  vertical: AppPadding.medium,
                ),
                itemCount: messages.length,
                separatorBuilder: (_, _) => verticalSpace(8),
                itemBuilder: (context, index) {
                  return MessageBubble(message: messages[index]);
                },
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
}
