import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetCurrentProfileUseCase {
  GetCurrentProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, ProfileEntity>> call() {
    return _repository.getCurrentProfile();
  }
}