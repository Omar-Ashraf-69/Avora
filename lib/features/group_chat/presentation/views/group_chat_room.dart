import 'dart:io';

import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/funcs/pick_image.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_Input.dart';
import 'package:avora/features/chat/presentation/views/widgets/image_message_preview.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_bubble.dart';
import 'package:avora/features/chat/presentation/views/widgets/scroll_down_floating_action_button.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/presentation/cubits/group_chat_cubit/group_chat_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/group_chat_cubit/group_chat_state.dart';
import 'package:avora/features/group_chat/presentation/views/widget/group_chat_room_app_bar.dart';
import 'package:avora/features/groups/domain/entities/get_group_details_use_case.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:avora/features/groups/domain/entities/group_member_entity.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroupChatRoom extends StatefulWidget {
  const GroupChatRoom({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
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

  GroupDetailsEntity? _groupDetails;
  final GetGroupDetailsUseCase getGroupDetailsUseCase =
      getIt<GetGroupDetailsUseCase>();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    context.read<GroupChatCubit>().loadMessages(
      conversationId: widget.conversationId,
    );

    _loadGroupDetails();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadGroupDetails() async {
    final result = await getGroupDetailsUseCase(
      conversationId: widget.conversationId,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        ToastNoContext.showCenterShortToast(message: failure.message);
      },
      (group) {
        setState(() {
          _groupDetails = group;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Skeletonizer(
          enabled: _groupDetails == null,
          child: GroupChatRoomAppBar(group: _groupDetails),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<GroupChatCubit, GroupChatState>(
                listener: _onChatStateChanged,
                builder: (context, state) {
                  if (state is GroupChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GroupChatLoaded) {
                    if (state.messages.isEmpty) {
                      return Center(
                        child: Text(
                          S.of(context).no_messages_yet,
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

    if (image == null) return;

    await Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<GroupChatCubit>(),
          child: ImagePreviewScreen(
            imageFile: File(image.path),
            onSend: (caption) async {
              return _sendGroupImage(context, File(image.path), caption);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _sendGroupImage(
    BuildContext context,
    File imageFile,
    String? caption,
  ) {
    return context.read<GroupChatCubit>().sendImageMessage(
      conversationId: widget.conversationId,
      imagePath: imageFile.path,
      content: caption,
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
            final isMe = message.senderId == currentUserId;
            return KeyedSubtree(
              key: ValueKey(message.id),
              child: MessageBubble(
                message: message,
                isMe: isMe,
                imageStorageDataSource: getIt<ImageStorageDataSource>(),
                status: null,
                sender: isMe ? null : _getSender(message.senderId),
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

  GroupMemberEntity? _getSender(String senderId) {
    final members = _groupDetails?.members;

    if (members == null) {
      return null;
    }

    for (final member in members) {
      if (member.userId == senderId) {
        return member;
      }
    }

    return null;
  }

  void _onChatStateChanged(BuildContext context, GroupChatState state) {
    if (state is! GroupChatLoaded) return;
    if (state is GroupChatFailure) {
      ToastNoContext.showCenterShortToast(message: state.errorMessage ?? '');
    }
    final messages = state.messages;

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

    _knownMessageIds
      ..clear()
      ..addAll(messages.map((message) => message.id));

    if (newMessages.isEmpty) return;

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

    context.read<GroupChatCubit>().sendTextMessage(
      conversationId: widget.conversationId,
      content: text,
    );

    _messageController.clear();

    _scrollToBottom();
  }
}
