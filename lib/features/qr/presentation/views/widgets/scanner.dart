// ignore: must_be_immutable
import 'package:avora/features/qr/presentation/views/widgets/scan_code_tab.dart';
import 'package:avora/features/qr/presentation/views/widgets/show_scanned_user_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// ignore: must_be_immutable
class Scanner extends StatelessWidget {
  Scanner({super.key, required this._scannerController, required this.mounted, required this.size});

  bool isProcessingScan = false;
  final MobileScannerController _scannerController;
  final bool mounted;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ScanCodeTab(
      size: size,
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
            await showScannedUserBottomSheet(
              // ignore: use_build_context_synchronously
              context: context,
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
    );
  }
}
