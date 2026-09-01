import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/localization/locale_provider.dart';
import 'package:avora/core/routing/app_router.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/routing/section_navigator.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AvoraApp extends StatefulWidget {
  const AvoraApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  State<AvoraApp> createState() => _AvoraAppState();
}

class _AvoraAppState extends State<AvoraApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider<SessionCubit>(
        create: (_) => getIt<SessionCubit>(),
        child: SessionNavigationListener(
          navigatorKey: _navigatorKey,
          child: MaterialApp(
            title: 'Avora',
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: Provider.of<LocaleProvider>(context).locale,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            ),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: widget.appRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
