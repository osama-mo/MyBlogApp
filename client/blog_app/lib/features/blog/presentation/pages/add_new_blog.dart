import 'dart:io';

import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/pick_image.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../data/models/blog_model.dart';
import '../bloc/blog_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  @override
  _AddNewBlogPageState createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedCategories = [];
  File? selectedImage;

  void selectImage() async {
    final image = await pickImage();
    if (image == null) return;
    setState(() {
      selectedImage = image;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.done_rounded),
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedCategories.isNotEmpty &&
                    selectedImage != null) {
                  BlocProvider.of<BlogBloc>(context).add(BlogUpload(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    topics: selectedCategories,
                    imageUrl: selectedImage!.path,
                  ));
                }
              },
            ),
          ],
          title: Text('Add New Blog'),
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            } else if (state is BlogFailure) {
              showSnackBar(context, 'Failed to upload blog');
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      selectedImage != null
                          ? GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImage!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Technology',
                            'Business',
                            'Entertainment',
                            'Health',
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedCategories.contains(e)) {
                                          selectedCategories.remove(e);
                                          setState(() {});
                                          return;
                                        }
                                        selectedCategories.add(e);
                                        setState(() {});
                                      },
                                      child: Chip(
                                        color: selectedCategories.contains(e)
                                            ? WidgetStateProperty.all<Color?>(
                                                AppPallete.gradient2)
                                            : WidgetStateProperty.all<Color?>(
                                                AppPallete.gradient1),
                                        label: Text(e,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      BlogEditor(
                          hintText: 'Blog Title', controller: titleController),
                      SizedBox(height: 16),
                      BlogEditor(
                          hintText: 'Blog Content',
                          controller: contentController),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
