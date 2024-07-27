import 'package:blog_app/features/blog/domain/enteties/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogsUseCase getAllBlogsUseCase;

  BlogBloc(this.uploadBlog, this.getAllBlogsUseCase)
      : super(
          BlogInitial(),
        ) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAll>(_onBlogGetAll);
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await uploadBlog(UploadBlogParams(
        title: event.title,
        content: event.content,
        topics: event.topics.first,
        imageUrl: event.imageUrl));
    result.fold((failure) => emit(BlogFailure(failure.message)),
        (blog) => emit(BlogSuccess()));
  }

  Future<void> _onBlogGetAll(BlogGetAll event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await getAllBlogsUseCase(NoParams());
    result.fold((failure) => emit(BlogFailure(failure.message)),
        (blogs) => emit(BlogSuccessWithBlogs(blogs)));
  }
}
