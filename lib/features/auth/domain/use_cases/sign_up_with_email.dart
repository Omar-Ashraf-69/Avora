import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repo;
  SignUpWithEmailAndPasswordUseCase(this._repo);


  Future<Either<Failure, User>> call({required String email, required String password}) async {
    return await _repo.signUpNewUser(email: email, password: password);
  }
}