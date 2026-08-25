import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteCurrentUserUseCase {
  DeleteCurrentUserUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<Either<Failure, void>> call() async{
   return await authRepository.deleteCurrentUser();
  }
}
