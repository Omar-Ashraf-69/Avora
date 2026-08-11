import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_app_bar.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_room_tile.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:flutter/material.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const ChatsAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        //child: const ChatsWelcomeView(),
        child: Column(
          children: [
            ChatsSearchField(),
            verticalSpace(12),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) => const ChatRoomTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
