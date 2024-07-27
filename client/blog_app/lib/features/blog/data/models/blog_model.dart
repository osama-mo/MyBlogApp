

import 'dart:convert';

import '../../domain/enteties/blog.dart';

class BlogModel extends Blog {
  BlogModel({ required super.title, required super.content, required super.imageUrl, required super.topics, required super.author, required super.createdAt });

  static List<BlogModel> listfromString(String body) {
  final parsed = json.decode(body).cast<Map<String, dynamic>>();
  return parsed.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();

  }
  
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json['title'],
      content: json['content'],
      imageUrl: json['image'],
      topics: json['category'],
      author: json['author'],
      createdAt: json['created_at'],
    );
  }


}