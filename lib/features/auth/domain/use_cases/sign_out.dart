import 'package:avora/features/auth/domain/repos/auth_repo.dart';

class SignOutUseCase {
  final AuthRepository _authRepo;

  SignOutUseCase(this._authRepo);  

  Future<void> call() => _authRepo.signOut();
}