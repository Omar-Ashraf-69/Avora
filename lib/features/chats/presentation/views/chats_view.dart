import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_floating_action_button.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_room_tile.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/features/chats/presentation/views/widgets/new_chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  Future<void> _startNewChat(BuildContext context) async {
    final conversationId = await showNewChatBottomSheet(context);

    if (!context.mounted) {
      return;
    }

    if (conversationId == null) {
      return;
    }

    context.pushNamed(
      AppRoutes.chatRoom,
      arguments: conversationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(),

      floatingActionButton: CustomFloatingActionButton(
        icon: HugeIcons.strokeRoundedChatAdd01,
        onPressed: () => _startNewChat(context),
      ),

      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        child: Column(
          children: [
            ChatsSearchField(),

            verticalSpace(12),

            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => context.pushNamed(
                      AppRoutes.chatRoom,
                      arguments: 'conversationId_$index',
                    ),
                    child: const ChatRoomTile(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}