import 'dart:convert';

import 'package:blog_app/core/common/enteties/user.dart';

class UserModel extends User {
  UserModel({
  required super.id,
  required super.email,
  required super.name});

factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] ?? -1,
    email: json['email'] ?? '',
    name: json['name'] ?? '',
  );

}

  static UserModel fromString(String body) {
    final Map<String, dynamic> json = jsonDecode(body);
    return UserModel.fromJson(json);
  }
}