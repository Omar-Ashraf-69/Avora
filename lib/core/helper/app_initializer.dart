import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppInitializer {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    await setupGetIt();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await loadEnv();
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? "",
      publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? "",
    );
  }

  String getInitialRoute() {
    return AppRoutes.login;
  }

  Future<void> loadEnv() async {
    try {
      await dotenv.load(fileName: ".env"); // Load environment variables
    } catch (e) {
      throw Exception('Error loading .env file: $e'); // Print error if any
    }
  }
}
