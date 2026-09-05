import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:flutter/material.dart';

void handleConversationState(BuildContext context, ConversationState state) {
  if (state is DirectConversationCreated) {
    Navigator.of(context).pop(state.conversationId);
    return;
  }

  if (state is ConversationFailure) {
    ToastNoContext.showColoredToast(message: state.message);
  }
}
