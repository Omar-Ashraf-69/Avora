import 'package:avora/core/auth/cubit/session_cubit.dart';
import 'package:avora/core/routing/app_router.dart';
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
import 'package:avora/features/chats/data/data_source/conversation_remote_data_source.dart';
import 'package:avora/features/chats/data/data_source/conversation_remote_data_source_impl.dart';
import 'package:avora/features/chats/data/data_source/conversation_status_realtime_data_source.dart';
import 'package:avora/features/chats/data/data_source/conversation_status_realtime_data_source_impl.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source_impl.dart';
import 'package:avora/features/chats/data/data_source/mark_pending_messages_as_delivered_use_case.dart';
import 'package:avora/features/chats/data/data_source/message_delivery_realtime_data_source.dart';
import 'package:avora/features/chats/data/data_source/message_delivery_realtime_data_source_impl.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source_impl.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source_impl.dart';
import 'package:avora/features/chats/data/repos/conversation_repository_impl.dart';
import 'package:avora/features/chats/data/repos/message_repository_impl.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:avora/features/chats/domain/use_case/create_direct_conversation.dart';
import 'package:avora/features/chats/domain/use_case/get_conversations.dart';
import 'package:avora/features/chats/domain/use_case/get_messages_use_case.dart';
import 'package:avora/features/chats/domain/use_case/get_other_participant_use_case.dart';
import 'package:avora/features/chats/domain/use_case/get_other_user_participant_message_states.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_delivered.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_read_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_image_message_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_text_message_use_case.dart';
import 'package:avora/features/chats/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:avora/features/chats/presentation/cubits/conversation_cubit/conversation_cubit.dart';
import 'package:avora/features/home/presentation/views/cubits/message_delivery_cubit.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source_impl.dart';
import 'package:avora/features/profile/data/repos/profile_repo_impl.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:avora/features/profile/domain/use_cases/create_profile.dart';
import 'package:avora/features/profile/domain/use_cases/find_user.dart';
import 'package:avora/features/profile/domain/use_cases/get_current_profile.dart';
import 'package:avora/features/profile/domain/use_cases/get_profile.dart';
import 'package:avora/features/profile/domain/use_cases/update_profile.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Shared Preferences
  await _registerSharedPreferences();
  _registerRouter();
  //Secure Storage
  // _registerSecureStorage();
  _registerSupabase();
  _registerDatabase();
  _registerProfile();
  _registerAuth();
  _registerConversation();
  _registerMessageDelivery();
}

void _registerRouter() =>
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());

void _registerDatabase() {
  getIt.registerLazySingleton<DatabaseService>(
    () => SupabaseDatabaseService(supabase: getIt<SupabaseClient>()),
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
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );

  getIt.registerLazySingleton(
    () => CreateProfileUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetCurrentProfileUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton(
    () => UpdateProfileUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton(
    () => FindUserUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerFactory(
    () => ProfileCubit(createProfileUseCase: getIt<CreateProfileUseCase>()),
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

  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<ProfileRepository>()),
  );

  //? Global Session

  getIt.registerSingleton<SessionCubit>(
    SessionCubit(
      supabase: getIt<SupabaseClient>(),
      authRepository: getIt<AuthRepository>(),
      getProfileUseCase: getIt<GetProfileUseCase>(),
    ),
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

void _registerMessageDelivery() {
  getIt.registerLazySingleton<MessageDeliveryRealtimeDataSource>(
    () => MessageDeliveryRealtimeDataSourceImpl(),
  );
  getIt.registerLazySingleton<MarkPendingMessagesAsDeliveredUseCase>(
    () => MarkPendingMessagesAsDeliveredUseCase(getIt<MessageRepository>()),
  );

  getIt.registerFactory<MessageDeliveryCubit>(
    () => MessageDeliveryCubit(
      messageDeliveryRealtimeDataSource:
          getIt<MessageDeliveryRealtimeDataSource>(),
      markConversationAsDeliveredUseCase:
          getIt<MarkConversationAsDeliveredUseCase>(),
      currentUserId: getIt<AuthRepository>().getCurrentUser()!.id,
      markPendingMessagesAsDeliveredUseCase: getIt<MarkPendingMessagesAsDeliveredUseCase>(),
    ),
  );
}

void _registerConversation() {
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  getIt.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSourceImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSourceRepo>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

  getIt.registerLazySingleton<ConversationRepository>(
    () => ConversationRepositoryImpl(getIt<ConversationRemoteDataSource>()),
  );

  getIt.registerLazySingleton<CreateDirectConversationUseCase>(
    () => CreateDirectConversationUseCase(getIt<ConversationRepository>()),
  );
  getIt.registerFactory<ConversationCubit>(
    () => ConversationCubit(
      findUserUseCase: getIt<FindUserUseCase>(),
      createDirectConversationUseCase: getIt<CreateDirectConversationUseCase>(),
    ),
  );

  getIt.registerLazySingleton<GetConversationsUseCase>(
    () => GetConversationsUseCase(getIt<ConversationRepository>()),
  );

  getIt.registerLazySingleton<MarkConversationAsReadUseCase>(
    () => MarkConversationAsReadUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<ImageStorageDataSource>(
    () => ImageStorageDataSourceImpl(supabaseClient: getIt<SupabaseClient>()),
  );
  getIt.registerFactory<ChatsCubit>(
    () => ChatsCubit(
      getConversationsUseCase: getIt<GetConversationsUseCase>(),
      supabaseClient: getIt<SupabaseClient>(),
    ),
  );

  getIt.registerLazySingleton<MessageRemoteDataSource>(
    () => MessageRemoteDataSourceImpl(
      databaseService: getIt<DatabaseService>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(
      getIt<MessageRemoteDataSource>(),
      imageStorageDataSource: getIt<ImageStorageDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(getIt<MessageRepository>()),
  );

  getIt.registerLazySingleton<SendTextMessageUseCase>(
    () => SendTextMessageUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<SendImageMessageUseCase>(
    () => SendImageMessageUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<MessageRealtimeDataSource>(
    () => MessageRealtimeDataSourceImpl(),
  );

  getIt.registerLazySingleton<GetOtherParticipantMessageStatusUseCase>(
    () => GetOtherParticipantMessageStatusUseCase(getIt<MessageRepository>()),
  );
  getIt.registerLazySingleton<ConversationStatusRealtimeDataSource>(
    () => ConversationStatusRealtimeDataSourceImpl(),
  );
  getIt.registerLazySingleton<GetOtherParticipantUseCase>(
    () => GetOtherParticipantUseCase(getIt<ConversationRepository>()),
  );
  getIt.registerLazySingleton<MarkConversationAsDeliveredUseCase>(
    () => MarkConversationAsDeliveredUseCase(getIt<MessageRepository>()),
  );

  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(
      getMessagesUseCase: getIt<GetMessagesUseCase>(),
      sendTextMessageUseCase: getIt<SendTextMessageUseCase>(),
      messageRealtimeDataSource: getIt<MessageRealtimeDataSource>(),
      markConversationAsReadUseCase: getIt<MarkConversationAsReadUseCase>(),
      sendImageMessageUseCase: getIt<SendImageMessageUseCase>(),
      authRepository: getIt<AuthRepository>(),
      markConversationAsDeliveredUseCase:
          getIt<MarkConversationAsDeliveredUseCase>(),
      conversationStatusRealtimeDataSource:
          getIt<ConversationStatusRealtimeDataSource>(),
      getOtherParticipantMessageStatusUseCase:
          getIt<GetOtherParticipantMessageStatusUseCase>(),
    ),
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
