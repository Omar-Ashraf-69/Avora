import 'dart:io';

import 'package:avora/core/funcs/custom_field_decoration.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    super.key,
    required this.imageFile,
    required this.onSend,
  });

  final File imageFile;
  final Future<bool> Function(String? caption) onSend;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TextEditingController _captionController =
      TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _sendImage() async {
    if (_isSending) {
      return;
    }

    final caption = _captionController.text.trim();

    setState(() {
      _isSending = true;
    });

    final success = await widget.onSend(
      caption.isEmpty ? null : caption,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.pop(context);
      return;
    }

    setState(() {
      _isSending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Failed to send image. Please try again.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: _isSending
              ? null
              : () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              child: Image.file(
                widget.imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 16.h,
            child: _buildBottomComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomComposer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 48.h,
              maxHeight: 120.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 4.h,
            ),
            child: TextField(
              controller: _captionController,
              enabled: !_isSending,
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              decoration: customFieldDecoration(
                'Send a caption...',
              ),
              style: TextStyles.regular15.copyWith(
                color: AppColors.darkBlue,
              ),
            ),
          ),
        ),
        horizontalSpace(2),
        Material(
          color: AppColors.mainBlue,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: _isSending ? null : _sendImage,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 52.w,
              height: 52.h,
              child: Center(
                child: _isSending
                    ? SizedBox(
                        width: 22.w,
                        height: 22.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        size: 24.sp,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
