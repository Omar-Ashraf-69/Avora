import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/chats/presentation/views/widgets/new_chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ================================================================
// Show New Chat Bottom Sheet
// ================================================================
Future<String?> showNewChatBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<ConversationCubit>(),
        child: const NewChatBottomSheet(),
      );
    },
  );
}
