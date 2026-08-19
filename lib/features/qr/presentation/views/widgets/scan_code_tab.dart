
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/features/qr/presentation/views/widgets/scanner_overlay.dart';
import 'package:flutter/material.dart';

class ScanCodeTab extends StatelessWidget {
  const ScanCodeTab({super.key, required this.size, required this.child});
  final double size;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightWhite,
      child: Stack(
        children: [
          // Camera View
          Center(
            child: SizedBox(
              width: size,
              height: size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: child,
              ),
            ),
          ),

          // Custom Scanner Overlay Design
          Center(
            child: CustomPaint(
              size: Size(size, size),
              painter: ScannerOverlayPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

