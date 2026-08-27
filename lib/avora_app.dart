import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/localization/locale_provider.dart';
import 'package:avora/core/routing/app_router.dart';
import 'package:avora/core/routing/app_start_view.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AvoraApp extends StatelessWidget {
  const AvoraApp({super.key, required this._appRouter});
  final AppRouter _appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => getIt<SessionCubit>()..initialize(),
        child: MaterialApp(
          title: 'Avora',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Provider.of<LocaleProvider>(context).locale,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,

          home: const AppStartView(),
        ),
      ),
    );
  }
}
