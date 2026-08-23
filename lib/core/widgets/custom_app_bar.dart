import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          context.pop();
        },
      ),
    ),
    title: Text(title, style: TextStyles.bold23),
  );
}
