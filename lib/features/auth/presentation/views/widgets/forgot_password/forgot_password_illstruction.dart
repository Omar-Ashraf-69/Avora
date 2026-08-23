import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordIllustration extends StatelessWidget {
  const ForgotPasswordIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF635BFF).withValues(alpha: 0.16),
                  const Color(0xFF635BFF).withValues(alpha: 0.02),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Envelope
          Positioned(
            bottom: 15.h,
            child: Container(
              width: 155.w,
              height: 105.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFDAD7FF), Color(0xFFBDB9FF)],
                ),
                borderRadius: BorderRadius.circular(17.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF635BFF).withValues(alpha: 0.15),
                    blurRadius: 25.r,
                    offset: Offset(0, 12.h),
                  ),
                ],
              ),
            ),
          ),

          // White envelope flap
          Positioned(
            top: 35.h,
            child: ClipPath(
              clipper: _EnvelopeFlapClipper(),
              child: Container(width: 155.w, height: 74.h, color: Colors.white),
            ),
          ),

          // Lock
          Positioned(
            top: 40.h,
            child: Container(
              width: 43.w,
              height: 37.h,
              decoration: BoxDecoration(
                color: const Color(0xFF635BFF),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF635BFF).withValues(alpha: 0.25),
                    blurRadius: 10.r,
                  ),
                ],
              ),
              child: Icon(Icons.lock_rounded, color: Colors.white, size: 22.r),
            ),
          ),

          // Paper plane
          Positioned(
            top: 20.h,
            right: 50.w,
            child: Transform.rotate(
              angle: -0.15,
              child: Icon(
                Icons.send_rounded,
                size: 34.r,
                color: const Color(0xFF766CFF),
              ),
            ),
          ),

          // Decorative sparkle
          Positioned(
            top: 15.h,
            left: 70.w,
            child: Icon(
              Icons.auto_awesome,
              size: 21.r,
              color: const Color(0xFFC5A7FF),
            ),
          ),

          // Decorative dot
          Positioned(
            bottom: 12.h,
            right: 70.w,
            child: Container(
              width: 13.w,
              height: 13.w,
              decoration: const BoxDecoration(
                color: Color(0xFF7DA4FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvelopeFlapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
