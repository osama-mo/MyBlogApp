import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/enteties/user.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser(this._authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}

class NoParams {
}