
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/enteties/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authDataSource;

  const AuthRepositoryImpl(this._authDataSource);
  
  @override
  Future<Either<Failure, User>> loginwithEmailPassword({required email, required String password}) async {
        try {
      final user = await _authDataSource.loginwithEmailPassword(email, password);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, User>> signUpwithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final user = await _authDataSource.signUpwithEmailPassword(name, email, password);
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await _authDataSource.getCurrentUser();
      if (user == null) {
        return Left(Failure("User not found"));
      }
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}