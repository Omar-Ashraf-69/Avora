import 'package:avora/core/funcs/custom_input_decoration.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDigitField extends StatelessWidget {
  const OtpDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onNext,
    this.onPrevious,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  final ValueChanged<String>? onChanged;

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        controller.text.isEmpty) {
      onPrevious?.call();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _handleChanged(String value) {
    onChanged?.call(value);

    if (value.length == 1) {
      onNext?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 60,
      child: Focus(
        onKeyEvent: _handleKeyEvent,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onTap: () {},
          onChanged: _handleChanged,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyles.bold23.copyWith(height: 1),
          cursorColor: AppColors.mainBlue,
          cursorHeight: 28,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: decoration,
        ),
      ),
    );
  }
}
