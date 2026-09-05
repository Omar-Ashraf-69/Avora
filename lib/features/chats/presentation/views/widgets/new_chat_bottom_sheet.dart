import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/funcs/phone_formater.dart';
import 'package:avora/core/helper/custom_toast.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewChatBottomSheet extends StatefulWidget {
  const NewChatBottomSheet({super.key});

  @override
  State<NewChatBottomSheet> createState() => _NewChatBottomSheetState();
}

class _NewChatBottomSheetState extends State<NewChatBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _identifierController = TextEditingController();
  final _identifierFocusNode = FocusNode();

  UserIdentifierType _identifierType = UserIdentifierType.phone;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _identifierFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _identifierFocusNode.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    final phoneNumber = value?.trim() ?? '';

    if (phoneNumber.isEmpty) {
      return 'Enter a phone number';
    }

    if (!PhoneNumberFormatter.isValidEgyptianPhone(phoneNumber)) {
      return 'Enter a valid Egyptian phone number';
    }

    return null;
  }

  String? _validateUsername(String? value) {
    var username = value?.trim() ?? '';

    if (username.isEmpty) {
      return 'Enter a username';
    }

    // Allow the user to type @username.
    username = username.replaceFirst('@', '');

    final validPattern = RegExp(r'^[a-zA-Z0-9_.]{2,30}$');

    if (!validPattern.hasMatch(username)) {
      return 'Username must be 2-30 characters';
    }

    return null;
  }

  void _onIdentifierTypeChanged(UserIdentifierType type) {
    // Remove focus from the old keyboard first.
    _identifierFocusNode.unfocus();

    // Clear the previous value because we're changing
    // between two completely different identifier types.
    _identifierController.clear();

    setState(() {
      _identifierType = type;
    });

    // Request focus again after the TextFormField has rebuilt.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _identifierFocusNode.requestFocus();
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final value = _identifierController.text.trim();

    final UserIdentifier identifier;

    if (_identifierType == UserIdentifierType.phone) {
      identifier = UserIdentifier(
        type: UserIdentifierType.phone,
        value: PhoneNumberFormatter.normalizeEgyptianPhone(value),
      );
    } else {
      identifier = UserIdentifier(
        type: UserIdentifierType.username,
        value: value.replaceFirst('@', '').toLowerCase(),
      );
    }

    context.read<ConversationCubit>().startDirectConversation(
      identifier: identifier,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationCubit, ConversationState>(
      listener: (context, state) {
        if (state is DirectConversationCreated) {
          // Return the conversation ID to ChatsView.
          //
          // This automatically closes the bottom sheet and disposes
          // its widget tree.
          Navigator.of(context).pop(state.conversationId);
        }

        if (state is ConversationFailure) {
          ToastNoContext.showColoredToast(message: state.message);
        }
      },
      child: BlocBuilder<ConversationCubit, ConversationState>(
        builder: (context, state) {
          final isLoading = state is ConversationLoading;

          final isPhone = _identifierType == UserIdentifierType.phone;

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
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
                    // Handle
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
                      'Find someone using their phone number or username.',
                      style: TextStyles.regular15.copyWith(
                        color: AppColors.gray,
                      ),
                    ),

                    verticalSpace(20),

                    // --------------------------------------------------
                    // Identifier type
                    // --------------------------------------------------
                    SegmentedButton<UserIdentifierType>(
                      segments: const [
                        ButtonSegment<UserIdentifierType>(
                          value: UserIdentifierType.phone,
                          label: Text('Phone'),
                          icon: Icon(Icons.phone),
                        ),
                        ButtonSegment<UserIdentifierType>(
                          value: UserIdentifierType.username,
                          label: Text('Username'),
                          icon: Icon(Icons.person),
                        ),
                      ],
                      selected: {_identifierType},
                      onSelectionChanged: isLoading
                          ? null
                          : (selection) {
                              _onIdentifierTypeChanged(selection.first);
                            },
                    ),

                    verticalSpace(20),

                    // --------------------------------------------------
                    // Identifier field
                    // --------------------------------------------------
                    TextFormField(
                      controller: _identifierController,
                      focusNode: _identifierFocusNode,
                      enabled: !isLoading,

                      keyboardType: isPhone
                          ? TextInputType.phone
                          : TextInputType.text,

                      textInputAction: TextInputAction.done,

                      inputFormatters: isPhone
                          ? [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9+]'),
                              ),
                            ]
                          : null,

                      decoration: customFieldDecoration(
                        isPhone ? '+201150913199' : '@username',
                        label: isPhone ? 'Phone number' : 'Username',
                        prefixIcon: Icon(
                          isPhone ? Icons.call : Icons.person,
                          color: AppColors.lightGray,
                        ),
                      ),

                      validator: isPhone ? _validatePhone : _validateUsername,

                      onFieldSubmitted: (_) => _submit(),
                    ),

                    verticalSpace(20),

                    // --------------------------------------------------
                    // Loading indicator
                    // --------------------------------------------------
                    if (isLoading) ...[
                      const LinearProgressIndicator(),
                      verticalSpace(12),
                    ],

                    // --------------------------------------------------
                    // Submit button
                    // --------------------------------------------------
                    CustomButton(
                      label: isLoading ? 'Starting...' : 'Start Chat',
                      onPressed: isLoading ? null : _submit,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================================================================
// Show New Chat Bottom Sheet
// ================================================================

Future<String?> showNewChatBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<ConversationCubit>(),
        child: const NewChatBottomSheet(),
      );
    },
  );
}
