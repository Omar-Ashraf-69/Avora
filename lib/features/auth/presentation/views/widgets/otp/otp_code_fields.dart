import 'package:avora/features/auth/presentation/views/widgets/otp/otp_digit_field.dart';
import 'package:flutter/material.dart';

class OtpCodeFields extends StatefulWidget {
  const OtpCodeFields({super.key, this.length = 6, this.onCompleted});

  final int length;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpCodeFields> createState() => _OtpCodeFieldsState();
}

class _OtpCodeFieldsState extends State<OtpCodeFields> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.length, (_) => TextEditingController());

    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _checkCompleted() {
    final code = _controllers.map((e) => e.text).join();

    if (code.length == widget.length) {
      FocusScope.of(context).unfocus();
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return OtpDigitField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],

          onNext: index == widget.length - 1
              ? null
              : () => _focusNodes[index + 1].requestFocus(),

          onPrevious: index == 0
              ? null
              : () => _focusNodes[index - 1].requestFocus(),

          onChanged: (_) => _checkCompleted(),
        );
      }),
    );
  }
}
