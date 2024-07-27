import 'dart:convert';

import 'package:blog_app/core/error/server_error.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpwithEmailPassword(
      String name, String email, String password);
  Future<UserModel> loginwithEmailPassword(String email, String password);
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signUpwithEmailPassword(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppSecrets.apiLink + AppSecrets.signupEndpoint),
        body: {
          'name': name,
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        log("message:${response.body}");
        
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonDecode(response.body)['token']);
        return UserModel.fromString(response.body);
      } else {
        log("message:${response.body}");
        throw ServerError.fromString(response.body).toString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> loginwithEmailPassword(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppSecrets.apiLink + AppSecrets.signinEndpoint),
        body: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        log("success" + response.body);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonDecode(response.body)['token']);
        return UserModel.fromString(response.body);
      } else {
        log("message:${response.body}");
        throw ServerError.fromString(response.body).toString();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      log("token is null");	
      return null;
    } else {
      final response = await http.post(
        Uri.parse(AppSecrets.apiLink + AppSecrets.currentUserEndpoint),
        body: {
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        log("success" + response.body);
        return UserModel.fromString(response.body);
      } else {
        log("message:${response.body}");
        return null;
      }
    }
  }
}
