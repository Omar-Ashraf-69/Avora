import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/chats_welcome_view.dart';
import 'package:avora/core/widgets/custom_floating_action_button.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/core/widgets/custom_loading_indecator.dart';
import 'package:avora/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/chats_cubit/chats_state.dart';
import 'package:avora/features/chats/presentation/views/func/start_new_chat.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_room_tile.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(),

      floatingActionButton: CustomFloatingActionButton(
        icon: HugeIcons.strokeRoundedChatAdd01,
        onPressed: () => startNewChat(context),
      ),

      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            if (state is ChatsLoading) {
              return const CustomLoadingIndecator();
            }

            if (state is ChatsFailure) {
              return Center(child: Text(state.message));
            }

            if (state is ChatsLoaded) {
              if (state.conversations.isEmpty) {
                return WelcomeViewColumn(
                  message:
                      "${S.of(context).start_a_converstion}\n ${S.of(context).with_your_friends_and_family}",
                );
              }

              return Column(
                children: [
                  ChatsSearchField(),
                  verticalSpace(12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        return GestureDetector(
                          onTap: () => context.pushNamed(
                            AppRoutes.chatRoom,
                            arguments: conversation.conversationId,
                          ),
                          child: ChatRoomTile(conversation: conversation),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
