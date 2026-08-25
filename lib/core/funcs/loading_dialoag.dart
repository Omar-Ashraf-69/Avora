import 'package:avora/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> loadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(color: AppColors.mainBlue),
    ),
  );
}
