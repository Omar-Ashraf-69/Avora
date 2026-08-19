import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_room_field_decoration.dart';
import 'package:avora/features/chat/presentation/views/widgets/send_button.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  const InputBar({
    super.key,
    required this.controller,
    required this._focusNode,
    required this.onFieldPressed,
    required this.onEmojiPressed,
    required this.onImagePressed,
    required this.onSendPressed,
  });

  final TextEditingController controller;
  final FocusNode _focusNode;
  final VoidCallback onFieldPressed;
  final VoidCallback onEmojiPressed;
  final VoidCallback onImagePressed;
  final VoidCallback onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.medium,
        vertical: AppPadding.small,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: _focusNode,
              onTap: onFieldPressed,
              minLines: 1,
              maxLines: 10,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              decoration: chatRoomFieldDecoration(
                S.of(context).type_a_message,
                onEmojiPressed: onEmojiPressed,
                onImagePressed: onImagePressed,
              ),
            ),
          ),

          horizontalSpace(8),

          SendButton(onPressed: onSendPressed),
        ],
      ),
    );
  }
}
