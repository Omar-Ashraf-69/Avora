import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _isDownloading = false;

  Future<File> _downloadImage() async {
    final directory = await getTemporaryDirectory();

    final filePath =
        '${directory.path}/avora_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await Dio().download(widget.imageUrl, filePath);

    return File(filePath);
  }

  Future<void> _saveImage() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
    });

    try {
      final file = await _downloadImage();

      await Gal.putImage(file.path);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Image saved to gallery')));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save image')));
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<void> _shareImage() async {
    try {
      final file = await _downloadImage();

      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to share image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
        actionsPadding: const EdgeInsetsDirectional.only(end: 16),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _isDownloading ? null : _saveImage,
            icon: _isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.download_outlined),
          ),

          IconButton(
            onPressed: _shareImage,
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),

      body: PhotoView(
        imageProvider: NetworkImage(widget.imageUrl),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
