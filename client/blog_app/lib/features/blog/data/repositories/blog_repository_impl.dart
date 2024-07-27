
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/error/server_error.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/enteties/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog({required String title, required String content, required String topics, required String imageUrl}) async {
    BlogModel blog = BlogModel(
      title: title,
      content: content,
      topics: topics,
      imageUrl: imageUrl,
      author: 'placeholder',
      createdAt: ''
    );
    try {
      final result = await blogRemoteDataSource.uploadBlog(blog);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final result = await blogRemoteDataSource.getAllBlogs();
      return Right(result);
    } on ServerError catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}