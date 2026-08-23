import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repo;

  GetCurrentUserUseCase(this._repo);

  User? call() => _repo.getCurrentUser();
}
