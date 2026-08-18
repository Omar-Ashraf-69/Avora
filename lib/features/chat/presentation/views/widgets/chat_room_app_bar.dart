
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chat/presentation/views/chat_room_view.dart';
import 'package:flutter/material.dart';

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({
    super.key,
    required this.context,
    required this.widget,
  });

  final BuildContext context;
  final ChatRoomView widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: widget.userImage != null
                ? NetworkImage(widget.userImage!)
                : null,
            child: widget.userImage == null ? const Icon(Icons.person) : null,
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.userName, style: TextStyles.semiBold16),
              verticalSpace(2),
              Text(
                widget.isOnline
                    ? 'Online'
                    : widget.lastSeen ?? 'Last seen recently',
                style: TextStyles.regular13.copyWith(
                  color: widget.isOnline ? AppColors.mainBlue : AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
