import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/auth/domain/usecases/user_login.dart';
import 'features/blog/data/repositories/blog_repository_impl.dart';
import 'features/blog/domain/repositories/blog_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  initAuthDependencies();
  initBlogDependencies();
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void initAuthDependencies() {
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<UserSignUp>(
    () => UserSignUp(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserLogin>(
    () => UserLogin(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<CurrentUser>(
    () => CurrentUser(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      appUserCubit: serviceLocator(),
      currentUser: serviceLocator(),
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}

void initBlogDependencies() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<UploadBlog>(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory<GetAllBlogsUseCase>(
      () => GetAllBlogsUseCase(serviceLocator()),
    )
    ..registerLazySingleton(() => BlogBloc(
          serviceLocator(),
          serviceLocator(),
        ));
}
