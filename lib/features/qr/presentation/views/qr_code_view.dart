import 'package:avora/features/qr/presentation/views/widgets/my_qr_code_tab.dart';
import 'package:avora/features/qr/presentation/views/widgets/qr_app_bar.dart';
import 'package:avora/features/qr/presentation/views/widgets/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: QrAppBar(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyQrCodeTab(),
          Scanner(
            scannerController: _scannerController,
            mounted: mounted,
            size: MediaQuery.of(context).size.width * 0.78,
          ),
        ],
      ),
    );
  }
}
