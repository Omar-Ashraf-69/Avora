import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/features/groups/presentation/views/widgets/groups_room_tile.dart';
import 'package:flutter/material.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        // child: WelcomeViewColumn(
        //   actionText: "Start New Group",
        //   message:
        //       "Get your friends and family together to share your thoughts and ideas ",
        // ),
        child: Column(
          children: [
            ChatsSearchField(),
            verticalSpace(12),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return GroupsRoomTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
