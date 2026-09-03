import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_floating_action_button.dart';
import 'package:avora/core/widgets/custom_home_app_bar.dart';
import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_room_tile.dart';
import 'package:avora/features/chats/presentation/views/widgets/chats_search_field.dart';
import 'package:avora/features/chats/presentation/views/widgets/new_chat_bottom_sheet.dart';
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
        onPressed: () async {
          await showNewChatBottomSheet(
            context,
            onStartChat: (phoneNumber) {
              //! TODO: Find user by phone number.
              //! TODO: Navigate to ChatRoomView.
              context.read<ConversationCubit>().createDirectConversation(
                otherUserId: "dc512ee6-f3a5-4c74-8bf4-599af10ec978",
              );
              debugPrint('Start chat with: $phoneNumber');
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
        ),

        // child: WelcomeViewColumn(
        //   actionText: S.of(context).start_new_chat,
        //   message:
        //       "${S.of(context).start_a_converstion}\n ${S.of(context).with_your_friends_and_family}",
        //   onPressed: () async {
        //     await showNewChatBottomSheet(
        //       context,
        //       onStartChat: (phoneNumber) {
        //         debugPrint('Start chat with: $phoneNumber');
        //       },
        //     );
        //   },
        // ),
        child: Column(
          children: [
            ChatsSearchField(),
            verticalSpace(12),
            BlocListener<ConversationCubit, ConversationState>(
              listener: (context, state) {
                if (state is DirectConversationCreated) {
                  debugPrint('Conversation created: ${state.conversationId}');

                  // Navigation will go here later.
                }

                if (state is ConversationFailure) {
                  debugPrint('Conversation creation failed: ${state.message}');
                }
              },
              child: Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.chatRoom),
                    child: const ChatRoomTile(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
