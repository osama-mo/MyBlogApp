import 'dart:convert';

import 'package:flutter/material.dart';

class ServerError {
  final int? statusCode;
  final String message;

  ServerError(this.statusCode, this.message);

  factory ServerError.fromJson(Map<String, dynamic> json) {
    return ServerError(
      json['statusCode'] as int?,
      json['error'] as String ?? '',
    );
  }

  factory ServerError.fromString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ServerError.fromJson(json);
  }
  String toString() {
    return message ;
  }
}
