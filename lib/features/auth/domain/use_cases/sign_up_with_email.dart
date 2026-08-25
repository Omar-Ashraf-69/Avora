import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repo;
  SignUpWithEmailAndPasswordUseCase(this._repo);


  Future<Either<Failure, UserModel>> call({required String email, required String password}) async {
    return await _repo.signUpNewUser(email: email, password: password);
  }
}