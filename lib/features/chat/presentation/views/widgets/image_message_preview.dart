import 'dart:io';

import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/features/chats/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    super.key,
    required this.imageFile,
    required this.conversationId,
  });

  final File imageFile;
  final String conversationId;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TextEditingController _captionController = TextEditingController();

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

    setState(() {
      _isSending = true;
    });

    final success = await context.read<ChatCubit>().sendImageMessage(
      conversationId: widget.conversationId,
      filePath: widget.imageFile.path,
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
      const SnackBar(content: Text('Failed to send image. Please try again.')),
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
          onPressed: _isSending ? null : () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              child: Image.file(widget.imageFile, fit: BoxFit.contain),
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
    return Material(
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
                : Icon(Icons.send_rounded, size: 24.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
