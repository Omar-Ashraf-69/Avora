import 'package:avora/features/auth/domain/entities/auth_user.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repo;

  GetCurrentUserUseCase(this._repo);

  AuthUser? call() => _repo.getCurrentUser();
}
