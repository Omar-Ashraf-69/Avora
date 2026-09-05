import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/chats/presentation/views/widgets/bottom_sheet/bottom_sheet_widgets.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:flutter/material.dart';

class ButtomSheetBody extends StatelessWidget {
  const ButtomSheetBody({
    super.key,
    required this._formKey,
    required this._identifierController,
    required this._identifierFocusNode,
    required this._identifierType,
    required this._isPhone,
    required this.isLoading,
    required this._buildIdentifierSelector,
    required this._submit,
  });
  final GlobalKey<FormState> _formKey;
  final TextEditingController _identifierController;
  final FocusNode _identifierFocusNode;
  final UserIdentifierType _identifierType;
  final bool _isPhone;
  final bool isLoading;
  final Widget _buildIdentifierSelector;
  final VoidCallback _submit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.medium,
          AppPadding.small,
          AppPadding.medium,
          AppPadding.medium,
        ),
        decoration: const BoxDecoration(
          color: AppColors.lightWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetWidgets.buildHandle(),
              verticalSpace(20),
              BottomSheetWidgets.buildTitle(context),
              verticalSpace(6),
              BottomSheetWidgets.buildDescription(context),
              verticalSpace(20),
              _buildIdentifierSelector,
              verticalSpace(20),
              BottomSheetWidgets.buildIdentifierField(
                isLoading,
                context,
                _identifierType,
                _identifierController,
                _identifierFocusNode,
                _isPhone,
                _submit,
              ),
              verticalSpace(20),
              if (isLoading) ...[
                BottomSheetWidgets.buildLoadingIndicator(context),
                verticalSpace(12),
              ],
              BottomSheetWidgets.buildSubmitButton(isLoading, context, _submit),
            ],
          ),
        ),
      ),
    );
  }
}
