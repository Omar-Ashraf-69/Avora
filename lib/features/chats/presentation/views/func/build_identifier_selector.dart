import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildIdentifierSelector({
  required UserIdentifierType identifierType,
  required bool isLoading,
  required ValueChanged<UserIdentifierType> onChanged,
}) {
  return SegmentedButton<UserIdentifierType>(
    segments: const [
      ButtonSegment<UserIdentifierType>(
        value: UserIdentifierType.phone,
        label: Text('Phone'),
        icon: FaIcon(FontAwesomeIcons.phone),
      ),
      ButtonSegment<UserIdentifierType>(
        value: UserIdentifierType.username,
        label: Text('Username'),
        icon: FaIcon(FontAwesomeIcons.user),
      ),
    ],
    selected: {identifierType},
    onSelectionChanged: isLoading
        ? null
        : (selection) {
            onChanged(selection.first);
          },
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }

          return AppColors.mainBlue;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mainBlue;
          }

          return Colors.transparent;
        },
      ),
      iconColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }

          return AppColors.mainBlue;
        },
      ),
    ),
  );
}