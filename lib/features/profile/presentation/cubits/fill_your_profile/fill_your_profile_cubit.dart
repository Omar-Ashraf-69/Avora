import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/domain/use_cases/create_profile.dart';
import 'package:avora/features/profile/presentation/cubits/fill_your_profile/fill_your_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.createProfileUseCase})
    : super(const ProfileInitial());

  final CreateProfileUseCase createProfileUseCase;

  Future<void> createProfile({required ProfileEntity profile}) async {
    emit(const ProfileLoading());

    final result = await createProfileUseCase(profile: profile);

    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (profile) => emit(ProfileCreated(profile)),
    );
  }
}
