import 'package:avora/core/di/dependecny_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avora/core/routing/app_routes.dart';

class AppInitializer {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await setupGetIt();
  }

  String getInitialRoute() {
    return AppRoutes.home;
  }
}
