
 import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/server_error.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../models/blog_model.dart';
import 'package:mime/mime.dart';

 import 'package:http/http.dart' as http;

abstract interface class BlogRemoteDataSource {
  Future<List<BlogModel>> getAllBlogs();
  Future<BlogModel> uploadBlog(BlogModel blog);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  
  
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

    final request = http.MultipartRequest('POST', Uri.parse(AppSecrets.apiLink + AppSecrets.createBlogEndpoint));
     
  request.fields['title'] = blog.title;
  request.fields['content'] = blog.content;
  request.fields['category'] = blog.topics;
  request.fields['author'] = 'placeholder';
  request.headers['Authorization'] = 'Token ${token}';

  request.files.add(await http.MultipartFile.fromPath(
      'image',
      blog.imageUrl
    ));

    final response = await request.send();

      if (response.statusCode == 201) {
        log("message:${await response.stream.transform(utf8.decoder).join()}");
        return blog;
      } else {
        log("message:${await response.stream.transform(utf8.decoder).join()}");
        throw ServerError.fromString(await response.stream.transform(utf8.decoder).join()).toString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs() async {        
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(AppSecrets.apiLink + AppSecrets.getAllBlogsEndpoint),
        headers: {
          'Authorization': 'Token ${token}',
        }
      );

      if (response.statusCode == 200) {
        log("success" + response.body);
        List<BlogModel> blogs = BlogModel.listfromString(response.body);
        return blogs;
      } else {
        log("message:${response.body}");
        throw ServerError.fromString(response.body).toString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  
  
} 