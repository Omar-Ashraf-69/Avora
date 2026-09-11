import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/full_screen_image.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatImage extends StatefulWidget {
  const ChatImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    required this.imageStorageDataSource,
    this.content,
    required this.isMe,
  });

  final String path;
  final double width;
  final double height;
  final ImageStorageDataSource imageStorageDataSource;
  final String? content;
  final bool isMe;

  @override
  State<ChatImage> createState() => _ChatImageState();
}

class _ChatImageState extends State<ChatImage> {
  String? _signedUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _createSignedUrl();
  }

  Future<void> _createSignedUrl() async {
    try {
      final signedUrl = await widget.imageStorageDataSource.createSignedUrl(
        path: widget.path,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _signedUrl = signedUrl;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildPlaceholder();
    }

    if (_signedUrl == null) {
      return _buildError();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImage(imageUrl: _signedUrl!),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: _signedUrl!,
              width: widget.width,
              height: widget.height,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return _buildPlaceholder();
              },
              errorWidget: (context, url, error) {
                return _buildError();
              },
            ),
            if (widget.content != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: AppPadding.small,
                  start: AppPadding.extraSmall,
                ),
                child: Text(
                  widget.content!,
                  style: TextStyles.regular15.copyWith(
                    color: widget.isMe ? Colors.white : AppColors.darkBlue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildError() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: const Center(child: Icon(Icons.broken_image_outlined)),
    );
  }
}
