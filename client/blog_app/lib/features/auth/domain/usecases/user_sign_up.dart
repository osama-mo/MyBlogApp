
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/enteties/user.dart';

class UserSignUp implements UseCase{
  final AuthRepository _authRepository;

  UserSignUp(this._authRepository);
  


    Future<Either<Failure, User>> call(params) async {
    return await _authRepository.signUpwithEmailPassword(name: params.name,email: params.email,password:  params.password);
  }

}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({required this.name,required this.email,required this.password});
}