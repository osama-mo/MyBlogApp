import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../enteties/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(
    {
      required String title,
      required String content,
      required String topics,
      required String imageUrl,
    }
  );

  Future<Either<Failure, List<Blog>>> getAllBlogs();

}