
import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../enteties/blog.dart';
import '../repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure,Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      topics: params.topics,
      imageUrl: params.imageUrl
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String topics;
  final String imageUrl;

  UploadBlogParams({required this.title, required this.content, required this.topics, required this.imageUrl});
}