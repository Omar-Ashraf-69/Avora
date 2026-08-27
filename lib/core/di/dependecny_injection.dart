import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo_impl.dart';
import 'package:avora/core/services/auth/supabase_auth_service.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/core/services/database/supabase_data_base_service.dart';
import 'package:avora/features/auth/data/repos/auth_repo_impl.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/auth/domain/use_cases/delete_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/get_current_user.dart';
import 'package:avora/features/auth/domain/use_cases/send_password_reset.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:avora/features/auth/domain/use_cases/sign_out.dart';
import 'package:avora/features/auth/domain/use_cases/sign_up_with_email.dart';
import 'package:avora/features/auth/domain/use_cases/update_password.dart';
import 'package:avora/features/auth/presentation/login_cubit/login_cubit.dart';
import 'package:avora/features/auth/presentation/fortgot_pass_cubit/forgot_pass_cubit.dart';
import 'package:avora/features/auth/presentation/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:avora/features/auth/presentation/sign_up_cubit/sign_up_cubit.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source_impl.dart';
import 'package:avora/features/profile/data/repos/profile_repo_impl.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:avora/features/profile/domain/use_cases/create_profile.dart';
import 'package:avora/features/profile/domain/use_cases/get_profile.dart';
import 'package:avora/features/profile/domain/use_cases/update_profile.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Shared Preferences
  await _registerSharedPreferences();
  //Secure Storage
  // _registerSecureStorage();
  _registerSupabase();
  _registerAuth();
  _registerDatabase();

    _registerProfile();

}


void _registerDatabase() {
  getIt.registerLazySingleton<DatabaseService>(
    () => SupabaseDatabaseService(
      supabase: getIt<SupabaseClient>(),
    ),
  );
}
void _registerProfile() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      databaseService: getIt<DatabaseService>(),
      authRemoteDataSource: getIt<AuthRemoteDataSourceRepo>(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      getIt<ProfileRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => CreateProfileUseCase(
      getIt<ProfileRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetCurrentProfileUseCase(
      getIt<ProfileRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => UpdateProfileUseCase(
      getIt<ProfileRepository>(),
    ),
  );

  getIt.registerFactory(
    () => ProfileCubit(
      createProfileUseCase: getIt<CreateProfileUseCase>(),
      
    ),
  );
}




void _registerAuth() {
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

  getIt.registerLazySingleton<DeleteCurrentUserUseCase>(
    () => DeleteCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UpdatePasswordUseCase>(
    () => UpdatePasswordUseCase(getIt<AuthRepository>()),
  );

  //? Global Session

  getIt.registerSingleton<SessionCubit>(
    SessionCubit(supabase: getIt<SupabaseClient>()),
  );
  //? Login Cubit
  getIt.registerFactory(
    () => LoginCubit(
      signInWithEmailUseCase: getIt<SignInWithEmailAndPasswordUseCase>(),
      signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
    ),
  );

  //? SignUp Cubit
  getIt.registerFactory<SignUpCubit>(
    () =>
        SignUpCubit(signUpUseCase: getIt<SignUpWithEmailAndPasswordUseCase>()),
  );

  getIt.registerFactory<ForgotPassCubit>(
    () => ForgotPassCubit(
      sendPasswordResetEmailUseCase: getIt<SendPasswordResetEmailUseCase>(),
    ),
  );

  getIt.registerFactory<ResetPassCubit>(
    () => ResetPassCubit(updatePasswordUseCase: getIt<UpdatePasswordUseCase>()),
  );
}

Future<void> _registerSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
}

void _registerSupabase() {
  // Supabase
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
}
