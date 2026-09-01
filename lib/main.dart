import 'package:avora/avora_app.dart';
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/helper/app_initializer.dart';
import 'package:avora/core/localization/locale_provider.dart';
import 'package:avora/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  final initializer = AppInitializer();
  await initializer.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: AvoraApp(appRouter: getIt<AppRouter>()),
    ),
  );
}
