import 'package:avora/core/localization/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderExt on BuildContext {
  LocaleProvider get localeProvider =>
      Provider.of<LocaleProvider>(this, listen: false);

  LocaleProvider get readLocaleProvider => read<LocaleProvider>();
}

extension LocaleExt on BuildContext {
  Locale get locale => Localizations.localeOf(this);

  bool get isArabic => locale.languageCode == 'ar';

  bool get isEnglish => locale.languageCode == 'en';
}


extension MeidaQueryExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}


extension NavigatorExtension on BuildContext {
  void pop() => Navigator.of(this).pop();
 //void pop<T extends Object?>([T? result]) =>
   // Navigator.of(this).pop(result);
  void pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);
  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  void pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) => Navigator.of(
    this,
  ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  void pushNamedAndRemoveAll(String routeName, {Object? arguments}) =>
      Navigator.of(
        this,
      ).pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
}
