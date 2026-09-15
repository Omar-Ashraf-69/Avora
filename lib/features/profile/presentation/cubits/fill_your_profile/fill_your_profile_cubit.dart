import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/domain/use_cases/create_profile.dart';
import 'package:avora/features/profile/domain/use_cases/upload_profile_avatar.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.createProfileUseCase,
    required this.uploadProfileAvatarUseCase,
  }) : super(const ProfileInitial());

  final CreateProfileUseCase createProfileUseCase;
  final UploadProfileAvatarUseCase uploadProfileAvatarUseCase;

  Future<void> createProfile({
    required ProfileEntity profile,
    String? avatarFilePath,
  }) async {
    emit(const ProfileLoading());

    String? avatarUrl;

    if (avatarFilePath != null) {
      final uploadResult = await uploadProfileAvatarUseCase(
        userId: profile.id,
        filePath: avatarFilePath,
      );

      final uploadSucceeded = uploadResult.fold(
        (failure) {
          emit(ProfileFailure(failure.message));
          return false;
        },
        (url) {
          avatarUrl = url;
          return true;
        },
      );

      if (!uploadSucceeded) return;
    }

    final profileWithAvatar = ProfileEntity(
      id: profile.id,
      name: profile.name,
      username: profile.username,
      phoneNumber: profile.phoneNumber,
      email: profile.email,
      about: profile.about,
      avatarUrl: avatarUrl,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );

    final result = await createProfileUseCase(
      profile: profileWithAvatar,
    );

    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (profile) => emit(ProfileCreated(profile)),
    );
  }
}
