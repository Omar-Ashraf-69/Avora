import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Shared Preferences
  await _registerSharedPreferences();
  //Secure Storage
  _registerSecureStorage();

}

void _registerSecureStorage() {
  const flutterSecureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
}

Future<void> _registerSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
}
