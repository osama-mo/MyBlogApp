import 'package:blog_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../enteties/blog.dart';
import '../repositories/blog_repository.dart';

class GetAllBlogsUseCase implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogsUseCase(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }

  
}

class NoParams {
}