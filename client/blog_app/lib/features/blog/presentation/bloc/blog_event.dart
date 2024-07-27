part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}


final class BlogUpload extends BlogEvent {
  final String title;
  final String content;
  final List<String> topics;
  final String imageUrl;

  BlogUpload({required this.title, required this.content, required this.topics, required this.imageUrl});
}

final class BlogGetAll extends BlogEvent {
  BlogGetAll();
}