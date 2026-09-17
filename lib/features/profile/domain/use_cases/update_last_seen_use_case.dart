import 'package:avora/features/profile/domain/repos/profile_repo.dart';

class UpdateLastSeenUseCase {
  UpdateLastSeenUseCase(
    this.profileRepository,
  );

  final ProfileRepository profileRepository;

  Future<void> call({
    required DateTime lastSeenAt,
  }) {
    return profileRepository.updateLastSeen(
      lastSeenAt: lastSeenAt,
    );
  }
}