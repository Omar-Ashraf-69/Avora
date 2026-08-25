import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {
  final AuthRepository _authRepo;

  SignOutUseCase(this._authRepo);  

  Future<Either<Failure, void>> call() => _authRepo.signOut();
}