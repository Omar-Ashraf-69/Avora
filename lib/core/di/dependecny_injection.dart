import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo_impl.dart';
import 'package:avora/core/services/auth/supabase_auth_service.dart';
import 'package:avora/features/auth/data/repos/auth_repo_impl.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/auth/domain/use_cases/get_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:avora/features/auth/domain/use_cases/sign_out.dart';
import 'package:avora/features/auth/domain/use_cases/sign_up_with_email.dart';
import 'package:avora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Shared Preferences
  await _registerSharedPreferences();
  //Secure Storage
  _registerSecureStorage();
  _registerSupabase();
  _registerAuth();
}

void _registerAuth() {
  getIt.registerFactory(() => AuthCubit());
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
  getIt.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthService(
      supabase: getIt<SupabaseClient>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  // Auth Data Source
  getIt.registerLazySingleton<AuthRemoteDataSourceRepo>(
    () =>
        AuthRemoteDataSourceRepoImpl(authService: getIt<SupabaseAuthService>()),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSourceRepo>()),
  );

  getIt.registerLazySingleton(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton(() => SignOutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => SignInWithEmailAndPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignUpWithEmailAndPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  );
}

void _registerSecureStorage() {
  const flutterSecureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
}

Future<void> _registerSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
}

void _registerSupabase() {
  // Supabase
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
