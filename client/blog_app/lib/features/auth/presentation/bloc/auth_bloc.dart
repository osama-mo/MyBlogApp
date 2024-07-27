import 'dart:async';
import 'dart:math';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../core/common/enteties/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required CurrentUser currentUser,
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<SignUpEvent>(_onAuthSignUp);
    on<LoginEvent>(_onAuthLogin);
    on<CurrentUserEvent>(_getCurrentUser);
  }

  FutureOr<void> _onAuthLogin(event, emit) async {
    await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    )).then((value) {
      value.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => _emitAuthSuccess(r, emit),
      );
    });
  }

  FutureOr<void> _onAuthSignUp(event, emit) async {
    await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    )).then((value) {
      value.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => _emitAuthSuccess(r, emit),
      );
    });
  }

  FutureOr<void> _getCurrentUser(event, emit) async {
    await _currentUser(NoParams()).then((value) {
      value.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => _emitAuthSuccess(r, emit),
      );
    });
  }

  void _emitAuthSuccess(user, emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
