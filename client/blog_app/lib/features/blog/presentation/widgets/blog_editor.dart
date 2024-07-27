import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditor({Key? key
  , required this.hintText
  , required this.controller

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: (value) => value!.isEmpty ? 'Please enter a valid $hintText' : null,
          controller: controller,
          maxLines: null,
        );
        
  }
}