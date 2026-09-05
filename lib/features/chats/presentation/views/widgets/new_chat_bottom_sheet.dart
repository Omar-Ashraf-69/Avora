import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/chats/presentation/views/func/build_identifer.dart';
import 'package:avora/features/chats/presentation/views/func/build_identifier_selector.dart';
import 'package:avora/features/chats/presentation/views/func/handel_conversation_state.dart';
import 'package:avora/features/chats/presentation/views/widgets/bottom_sheet/bottom_sheet_body.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:flutter/material.dart';
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

  bool get _isPhone => _identifierType == UserIdentifierType.phone;

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

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConversationCubit, ConversationState>(
      listener: handleConversationState,
      child: BlocBuilder<ConversationCubit, ConversationState>(
        builder: (context, state) {
          return ButtomSheetBody(
            formKey: _formKey,
            identifierController: _identifierController,
            identifierFocusNode: _identifierFocusNode,
            identifierType: _identifierType,
            isPhone: _isPhone,
            isLoading: state is ConversationLoading,
            buildIdentifierSelector: buildIdentifierSelector(
              identifierType: _identifierType,
              isLoading: state is ConversationLoading,
              onChanged: _onIdentifierTypeChanged,
            ),
            submit: _submit,
          );
        },
      ),
    );
  }

  void _onIdentifierTypeChanged(UserIdentifierType type) {
    _identifierFocusNode.unfocus();
    _identifierController.clear();

    setState(() {
      _identifierType = type;
    });

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
    context.read<ConversationCubit>().startDirectConversation(
      identifier: buildIdentifier(
        identifierController: _identifierController,
        isPhone: _isPhone,
      ),
    );
  }
}