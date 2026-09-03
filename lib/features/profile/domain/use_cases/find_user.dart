import 'package:avora/features/profile/domain/entities/public_profile_entity.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_identifier.dart';

class FindUserUseCase {
  const FindUserUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, PublicProfileEntity?>> call({
    required UserIdentifier identifier,
  }) {
    return _repository.findUser(
      identifier: identifier,
    );
  }
}