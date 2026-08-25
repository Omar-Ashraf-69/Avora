import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repo;
  SignInWithGoogleUseCase(this._repo);

  Future<Either<Failure, UserModel>> call() async {
    return await _repo.signInWithGoogle();
  }
}
