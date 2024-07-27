import 'dart:core';

import 'package:blog_app/core/error/failures.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/enteties/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginwithEmailPassword({required  email,required String password});
  Future<Either<Failure, User>> signUpwithEmailPassword({required String name ,required String email,required String password});
  Future<Either<Failure, User>> getCurrentUser();
}