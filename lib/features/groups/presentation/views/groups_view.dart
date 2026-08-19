import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_floating_action_button.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/features/groups/presentation/views/widgets/groups_room_tile.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(),
      floatingActionButton: CustomFloatingActionButton(
        icon: HugeIcons.strokeRoundedUserGroup,
        onPressed: () {
          context.pushNamed(AppRoutes.createGroup);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        // child: WelcomeViewColumn(
        //   actionText: S.of(context).start_new_group,
        //   message: S.of(context).get_your_friends_to,
        //   onPressed: () {
        //     context.pushNamed(AppRoutes.createGroup);
        //   },
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
