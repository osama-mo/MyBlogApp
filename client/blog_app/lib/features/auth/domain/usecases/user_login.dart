import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/enteties/user.dart';

class UserLogin implements UseCase {
  final AuthRepository _authRepository;

  UserLogin(this._authRepository);

  
  @override
  Future<Either<Failure, dynamic>> call(params) async {
  return await _authRepository.loginwithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
