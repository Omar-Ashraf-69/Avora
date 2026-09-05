import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/chats/presentation/views/func/show_new_chat_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<void> startNewChat(BuildContext context) async {
  final conversationId = await showNewChatBottomSheet(context);

  if (!context.mounted) {
    return;
  }

  if (conversationId == null) {
    return;
  }

  context.pushNamed(AppRoutes.chatRoom, arguments: conversationId);
}
