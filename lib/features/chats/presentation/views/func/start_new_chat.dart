import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:avora/features/chats/presentation/views/func/show_new_chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> startNewChat(BuildContext context) async {
  final conversationId = await showNewChatBottomSheet(context);

  if (!context.mounted || conversationId == null) {
    return;
  }

  await context.read<ChatsCubit>().loadConversations();

  if (!context.mounted) {
    return;
  }

  context.pushNamed(AppRoutes.chatRoom, arguments: conversationId);
}
