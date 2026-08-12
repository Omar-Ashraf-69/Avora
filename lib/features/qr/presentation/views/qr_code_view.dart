import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeView extends StatefulWidget {
  const QrCodeView({super.key});

  @override
  State<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.imagesSvgsAppIcon,
              height: 44.h,
              width: 44.w,
              colorFilter: const ColorFilter.mode(
                AppColors.mainBlue,
                BlendMode.srcIn,
              ),
            ),
            Text(S.of(context).qr_code, style: TextStyles.bold23),
          ],
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyles.bold16,
          labelColor: AppColors.mainBlue,
          dividerColor: AppColors.lightBlue,
          indicatorColor: AppColors.mainBlue,
          unselectedLabelColor: AppColors.gray,
          tabs: const [
            Tab(text: 'My Code'),
            Tab(text: 'Scan Code'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildMyCodeTab(), _buildScanCodeTab()],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: MY CODE
  // ---------------------------------------------------------------------------

  Widget _buildMyCodeTab() {
    return Container(
      color: AppColors.lightWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 24.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 45.r,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=300',
                ),
              ),
              verticalSpace(16),

              // Name
              Text('Andrew Ainsley', style: TextStyles.bold23),
              verticalSpace(4),

              // Subtitle
              Text(
                'Avora Contact',
                style: TextStyles.regular13.copyWith(
                  color: AppColors.lightGray,
                ),
              ),
              verticalSpace(20),
              // Generated QR Code
              QrImageView(
                data: 'https://hichat.app/user/andrew_ainsley',
                version: QrVersions.auto,
                size: 200.h,
                backgroundColor: Colors.white,
              ),
              verticalSpace(20),

              // Disclaimer
              Text(
                'Your QR Code is private. Please\nshare only with people you trust',
                textAlign: TextAlign.center,
                style: TextStyles.regular13.copyWith(
                  color: AppColors.lightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: SCAN CODE
  // ---------------------------------------------------------------------------
  Widget _buildScanCodeTab() {
    final size = MediaQuery.sizeOf(context).width * 0.78;
    bool isProcessingScan = false;
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

                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) async {
                    if (isProcessingScan) return;

                    for (final barcode in capture.barcodes) {
                      final value = barcode.rawValue;

                      if (value == null || value.isEmpty) continue;

                      isProcessingScan = true;

                      await _scannerController.stop();

                      if (!mounted) return;

                      await _showScannedUserBottomSheet(
                        username: 'Andrew Ainsley',
                        phoneNumber: '+1 123 456 7890',
                      );

                      if (!mounted) return;

                      isProcessingScan = false;

                      await _scannerController.start();

                      break;
                    }
                  },
                ),
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

  Future<void> _showScannedUserBottomSheet({
    required String username,
    required String phoneNumber,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _ScannedUserBottomSheet(
          username: username,
          phoneNumber: phoneNumber,
          onStartChatting: () {
            Navigator.pop(context);

            context.pushNamedAndRemoveAll(AppRoutes.home);
          },
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// CUSTOM OVERLAY PAINTER (Rounded Blue Corners)
// -----------------------------------------------------------------------------
class ScannerOverlayPainter extends CustomPainter {
  const ScannerOverlayPainter();

  final Color color = AppColors.mainBlue;
  final double strokeWidth = 4;
  final double cornerLength = 32;
  final double borderRadius = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final halfStroke = strokeWidth / 2;

    final rect = Rect.fromLTWH(
      halfStroke,
      halfStroke,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final path = Path();

    // Top-left
    path.moveTo(rrect.left, rrect.top + cornerLength);
    path.lineTo(rrect.left, rrect.top + borderRadius);
    path.quadraticBezierTo(
      rrect.left,
      rrect.top,
      rrect.left + borderRadius,
      rrect.top,
    );
    path.lineTo(rrect.left + cornerLength, rrect.top);

    // Top-right
    path.moveTo(rrect.right - cornerLength, rrect.top);
    path.lineTo(rrect.right - borderRadius, rrect.top);
    path.quadraticBezierTo(
      rrect.right,
      rrect.top,
      rrect.right,
      rrect.top + borderRadius,
    );
    path.lineTo(rrect.right, rrect.top + cornerLength);

    // Bottom-right
    path.moveTo(rrect.right, rrect.bottom - cornerLength);
    path.lineTo(rrect.right, rrect.bottom - borderRadius);
    path.quadraticBezierTo(
      rrect.right,
      rrect.bottom,
      rrect.right - borderRadius,
      rrect.bottom,
    );
    path.lineTo(rrect.right - cornerLength, rrect.bottom);

    // Bottom-left
    path.moveTo(rrect.left + cornerLength, rrect.bottom);
    path.lineTo(rrect.left + borderRadius, rrect.bottom);
    path.quadraticBezierTo(
      rrect.left,
      rrect.bottom,
      rrect.left,
      rrect.bottom - borderRadius,
    );
    path.lineTo(rrect.left, rrect.bottom - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.cornerLength != cornerLength ||
        oldDelegate.borderRadius != borderRadius;
  }
}

class _ScannedUserBottomSheet extends StatelessWidget {
  const _ScannedUserBottomSheet({
    required this.username,
    required this.phoneNumber,
    required this.onStartChatting,
  });

  final String username;
  final String phoneNumber;
  final VoidCallback onStartChatting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.medium,
        12,
        AppPadding.medium,
        24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            verticalSpace(24),

            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.lightBlue,
              child: Icon(Icons.person, size: 42, color: AppColors.mainBlue),
            ),

            verticalSpace(16),

            Text(
              username,
              style: TextStyles.bold23,
              textAlign: TextAlign.center,
            ),

            verticalSpace(6),

            Text(
              phoneNumber,
              style: TextStyles.regular16.copyWith(color: AppColors.gray),
            ),

            verticalSpace(24),

            Text(
              'You found this contact using their QR code.',
              style: TextStyles.regular13.copyWith(color: AppColors.lightGray),
              textAlign: TextAlign.center,
            ),

            verticalSpace(24),

            CustomButton(label: 'Start Chatting', onPressed: onStartChatting),

            verticalSpace(8),

            TextButton(
              onPressed: () => Navigator.pop(context),

              child: Text(
                'Cancel',
                style: TextStyles.semiBold16.copyWith(color: AppColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
