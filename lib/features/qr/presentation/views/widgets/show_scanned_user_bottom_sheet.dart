import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/features/qr/presentation/views/widgets/scanned_user_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<void> showScannedUserBottomSheet({
    required String username,
    required String phoneNumber,
    required BuildContext context
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ScannedUserBottomSheet(
          username: username,
          phoneNumber: phoneNumber,
          onStartChatting: () {
            Navigator.pop(context);

            context.pushNamedAndRemoveAll(AppRoutes.home);
          },
        );
      },
    );
  }