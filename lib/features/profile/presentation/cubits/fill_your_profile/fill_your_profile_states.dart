import 'package:avora/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileCreated extends ProfileState {
  final ProfileEntity profile;

  const ProfileCreated(this.profile);
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);
}