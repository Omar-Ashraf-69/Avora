import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avora/core/routing/app_routes.dart';

class AppInitializer {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await setupGetIt();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  String getInitialRoute() {
    return AppRoutes.login;
  }
}
