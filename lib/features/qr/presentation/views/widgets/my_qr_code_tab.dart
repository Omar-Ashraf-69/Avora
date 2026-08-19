import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCodeTab extends StatelessWidget {
  const MyQrCodeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
