import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/chats_welcome_view.dart';
import 'package:avora/core/widgets/custom_floating_action_button.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/features/groups/presentation/cubits/groups_cubit/groups_cubit.dart';
import 'package:avora/features/groups/presentation/cubits/groups_cubit/groups_state.dart';
import 'package:avora/features/groups/presentation/views/widgets/groups_room_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:avora/generated/l10n.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  void initState() {
    super.initState();

    context.read<GroupsCubit>().loadGroups();
  }

  void _startNewGroup() {
    context.pushNamed(AppRoutes.createGroup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(),
      floatingActionButton: CustomFloatingActionButton(
        icon: HugeIcons.strokeRoundedUserGroup,
        onPressed: _startNewGroup,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        child: BlocConsumer<GroupsCubit, GroupsState>(
          listener: (context, state) {
            if (state is GroupsFailure) {
              ToastNoContext.showColoredToast(message: state.message);
            }
          },
          builder: (context, state) {
            if (state is GroupsLoading) {
              return Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.mainBlue,
                  size: 30.r,
                ),
              );
            }

            if (state is GroupsLoaded) {
              if (state.groups.isEmpty) {
                return WelcomeViewColumn(
                  message: S.of(context).get_your_friends_to,
                );
              }

              return Column(
                children: [
                  const ChatsSearchField(),
                  verticalSpace(12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        final group = state.groups[index];

                        return GroupsRoomTile(group: group);
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is GroupsFailure) {
              return const SizedBox.shrink();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
