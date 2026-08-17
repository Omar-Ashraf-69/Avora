import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
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

  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hey! How are you?', time: '10:30 AM', isMe: false),
    ChatMessage(
      text: 'I am good! How about you?',
      time: '10:31 AM',
      isMe: true,
      status: MessageStatus.seen,
    ),
    ChatMessage(text: 'Doing great 😊', time: '10:32 AM', isMe: false),
    ChatMessage(
      text: 'Are you free today?',
      time: '10:33 AM',
      isMe: true,
      status: MessageStatus.seen,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          time: _currentTime(),
          isMe: true,
          status: MessageStatus.sent,
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
        curve: Curves.easeOut,
      );
    });
  }

  String _currentTime() {
    final now = TimeOfDay.now();

    return now.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.medium,
                  vertical: 16,
                ),
                itemCount: _messages.length,
                separatorBuilder: (_, _) => verticalSpace(8),
                itemBuilder: (context, index) {
                  return MessageBubble(message: _messages[index]);
                },
              ),
            ),
            ChatInput(
              controller: _messageController,
              onSend: _sendMessage,
              onImagePressed: _pickImage,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: widget.userImage != null
                ? NetworkImage(widget.userImage!)
                : null,
            child: widget.userImage == null ? const Icon(Icons.person) : null,
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.userName, style: TextStyles.semiBold16),
              verticalSpace(2),
              Text(
                widget.isOnline
                    ? 'Online'
                    : widget.lastSeen ?? 'Last seen recently',
                style: TextStyles.regular13.copyWith(
                  color: widget.isOnline ? AppColors.mainBlue : AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _pickImage() {
    // TODO: Implement image picker.
  }
}

enum MessageStatus { sent, delivered, seen }

class ChatMessage {
  const ChatMessage({
    this.text,
    required this.time,
    required this.isMe,
    this.status,
    this.imageUrl,
  });

  final String? text;
  final String time;
  final bool isMe;
  final MessageStatus? status;
  final String? imageUrl;

  bool get isImage => imageUrl != null;
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .78,
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 6),
        decoration: BoxDecoration(
          color: isMe ? AppColors.mainBlue : AppColors.lightWhite,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(16),
            topEnd: const Radius.circular(16),
            bottomStart: Radius.circular(isMe ? 16 : 4),
            bottomEnd: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (message.isImage) {
      return _buildImageMessage(context);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            message.text ?? '',
            style: TextStyles.regular15.copyWith(
              color: message.isMe ? Colors.white : AppColors.darkBlue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        _MessageMeta(message: message),
      ],
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        message.imageUrl!,
        width: MediaQuery.sizeOf(context).width * .65,
        height: 220,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MessageMeta extends StatelessWidget {
  const _MessageMeta({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message.time,
          style: TextStyles.regular13.copyWith(
            color: message.isMe ? Colors.white70 : AppColors.gray,
          ),
        ),
        if (message.isMe) ...[const SizedBox(width: 3), _buildStatusIcon()],
      ],
    );
  }

  Widget _buildStatusIcon() {
    switch (message.status) {
      case MessageStatus.seen:
        return const Icon(
          Icons.done_all,
          size: 16,
          color: Colors.lightBlueAccent,
        );

      case MessageStatus.delivered:
        return const Icon(Icons.done_all, size: 16, color: Colors.white70);

      case MessageStatus.sent:
        return const Icon(Icons.done, size: 16, color: Colors.white70);

      case null:
        return const SizedBox.shrink();
    }
  }
}

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
