import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/validators.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class BottomSheetWidgets  {
  


static Widget buildIdentifierField(bool isLoading, BuildContext context,UserIdentifierType identifierType, TextEditingController identifierController, FocusNode identifierFocusNode, bool isPhone, VoidCallback submit) {
    return TextFormField(
      controller: identifierController,
      focusNode: identifierFocusNode,
      enabled: !isLoading,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      textInputAction: TextInputAction.done,
      inputFormatters: isPhone
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))]
          : null,
      decoration: customFieldDecoration(
        isPhone ? '+201234567890' : S.of(context).at_username,
        label: isPhone ? S.of(context).phone_number : S.of(context).username,
        prefixIcon: Icon(
          isPhone ? Icons.call : Icons.person,
          color: AppColors.lightGray,
        ),
      ),
      validator: isPhone
          ? AppValidators.validatePhone
          : AppValidators.validateUsername,
      onFieldSubmitted: (_) => submit(),
    );
  }
 static Widget buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static Widget buildTitle(BuildContext context) {
    return Text(S.of(context).new_chat, style: TextStyles.bold23);
  }

  
  static Widget buildDescription(BuildContext context) {
    return Text(
      S.of(context).find_someone_by_username_or_phone_number,
      style: TextStyles.regular15.copyWith(color: AppColors.gray),
    );
  }

  static   Widget buildLoadingIndicator(BuildContext context) {
    return const LinearProgressIndicator(minHeight: 2,
      backgroundColor: AppColors.lightGray,
      color: AppColors.mainBlue,

    );
  }

  static Widget buildSubmitButton(bool isLoading,BuildContext context,VoidCallback submit) {
    return CustomButton(
      label: isLoading ? S.of(context).starting : S.of(context).start_chat,
      onPressed: isLoading ? null : submit,
    );
  }
}
