import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewChatBottomSheet extends StatefulWidget {
  const NewChatBottomSheet({super.key, required this.onStartChat});

  final ValueChanged<String> onStartChat;

  @override
  State<NewChatBottomSheet> createState() => _NewChatBottomSheetState();
}

class _NewChatBottomSheetState extends State<NewChatBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _phoneFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    final phoneNumber = value?.trim() ?? '';

    if (phoneNumber.isEmpty) {
      return 'Enter a phone number';
    }

    final validPattern = RegExp(r'^\+?[0-9]{7,15}$');

    if (!validPattern.hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final phoneNumber = _phoneController.text.trim();
    context.pop();
    widget.onStartChat(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
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
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              verticalSpace(20),
              Text('New Chat', style: TextStyles.bold23),
              verticalSpace(6),
              Text(
                'Enter the phone number of the person you want to chat with.',
                style: TextStyles.regular15.copyWith(color: AppColors.gray),
              ),
              verticalSpace(20),
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                ],
                decoration: customFieldDecoration(
                  '+1234567890',
                  label: 'Phone number',
                  prefixIcon: const Icon(
                    Icons.call,
                    color: AppColors.lightGray,
                  ),
                ),
                validator: _validatePhone,
                onFieldSubmitted: (_) => _submit(),
              ),
              verticalSpace(20),
              // Start chat button
              CustomButton(label: 'Start Chat', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}



Future<void> showNewChatBottomSheet(
  BuildContext context, {
  required ValueChanged<String> onStartChat,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => NewChatBottomSheet(onStartChat: onStartChat),
  );
}