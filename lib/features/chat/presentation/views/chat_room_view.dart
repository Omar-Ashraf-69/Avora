import 'dart:io';

import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/funcs/pick_image.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_Input.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_room_app_bar.dart';
import 'package:avora/features/chat/presentation/views/widgets/image_message_preview.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:avora/features/chat/presentation/views/widgets/scroll_down_floating_action_button.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/use_case/get_other_participant_use_case.dart';
import 'package:avora/features/chats/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  // Number of incoming messages received while the user
  // is away from the bottom of the chat.
  int _newMessagesCount = 0;

  // IDs of messages that we have already seen in the current
  // ChatRoom session. This prevents counting the same message
  // more than once.
  bool _hasInitializedMessages = false;
  final Set<String> _knownMessageIds = {};
  ProfileEntity? _otherParticipant;
  final GetOtherParticipantUseCase getOtherParticipantUseCase =
      getIt<GetOtherParticipantUseCase>();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    context.read<ChatCubit>().loadMessages(
      conversationId: widget.conversationId,
    );
    _loadOtherParticipant();
  }

  Future<void> _loadOtherParticipant() async {
    final result = await getOtherParticipantUseCase(
      conversationId: widget.conversationId,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        // Handle later.
      },
      (profile) {
        setState(() {
          _otherParticipant = profile;
        });
      },
    );
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
        child: Skeletonizer(
    enabled: _otherParticipant == null,
    child: ChatRoomAppBar(
      context: context,
      profile: _otherParticipant,
    ),
  ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: _onChatStateChanged,
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ChatFailure) {
                    ToastNoContext.showCenterShortToast(message: state.message);
                  }

                  if (state is ChatLoaded) {
                    if (state.messages.isEmpty) {
                      return Center(
                        child: Text(
                          "No messages yet. Start the conversation!",
                          style: TextStyles.regular16,
                        ),
                      );
                    }
                    return _buildMessageList(state.messages);
                  }

                  return const SizedBox.shrink();
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

  Future<void> _pickImage() async {
    final image = await pickImage(context);

    // if (image != null) return;
    await Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ChatCubit>(),
          child: ImagePreviewScreen(
            imageFile: File(image!.path),
            conversationId: widget.conversationId,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(List<MessageEntity> messages) {
    final currentUserId = getIt<AuthRepository>().getCurrentUser()?.id;

    if (currentUserId == null) {
      return const SizedBox.shrink();
    }

    return Stack(
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
            return KeyedSubtree(
              key: ValueKey(message.id),
              child: MessageBubble(
                message: message,
                isMe: message.senderId == currentUserId,
                imageStorageDataSource: getIt<ImageStorageDataSource>(),
              ),
            );
          },
        ),
        ScrollDownFloatingActionButton(
          onPressed: _scrollToBottom,
          showScrollToBottomButton: _showScrollToBottomButton,
          unreadMessagesCount: _newMessagesCount,
        ),
      ],
    );
  }

  void _onChatStateChanged(BuildContext context, ChatState state) {
    if (state is! ChatLoaded) return;

    final messages = state.messages;

    // First ChatLoaded state = initial data.
    // Register existing messages without counting them.
    if (!_hasInitializedMessages) {
      _hasInitializedMessages = true;

      _knownMessageIds
        ..clear()
        ..addAll(messages.map((message) => message.id));

      return;
    }

    final currentUserId = getIt<AuthRepository>().getCurrentUser()?.id;

    if (currentUserId == null) return;

    final newMessages = messages
        .where((message) => !_knownMessageIds.contains(message.id))
        .toList();

    // Always update known IDs.
    _knownMessageIds
      ..clear()
      ..addAll(messages.map((message) => message.id));

    if (newMessages.isEmpty) return;

    // Don't show a counter if we're already at the bottom.
    if (_isAtBottom) return;

    final incomingMessages = newMessages.where(
      (message) => message.senderId != currentUserId,
    );

    if (incomingMessages.isEmpty) return;

    setState(() {
      _newMessagesCount += incomingMessages.length;
    });
  }

  bool get _isAtBottom {
    if (!_scrollController.hasClients) {
      return true;
    }

    return _scrollController.offset <= _scrollThreshold;
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final isAtBottom = _isAtBottom;

    final shouldShowButton = !isAtBottom;

    if (isAtBottom && _newMessagesCount != 0) {
      setState(() {
        _newMessagesCount = 0;
      });
    }

    if (shouldShowButton == _showScrollToBottomButton) {
      return;
    }

    setState(() {
      _showScrollToBottomButton = shouldShowButton;
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    // The user is intentionally going to the bottom,
    // so clear the new-message counter.
    if (_newMessagesCount != 0) {
      setState(() {
        _newMessagesCount = 0;
      });
    }

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    context.read<ChatCubit>().sendTextMessage(
      conversationId: widget.conversationId,
      content: text,
    );

    _messageController.clear();

    // With reverse:true, bottom = 0.
    _scrollToBottom();
  }
}
