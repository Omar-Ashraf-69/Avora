import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, ProfileEntity>> call({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  }) {
    return _repository.updateProfile(
      username: username,
      name: name,
      about: about,
      avatarUrl: avatarUrl,
    );
  }
}