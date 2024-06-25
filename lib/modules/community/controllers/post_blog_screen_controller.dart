import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/blog.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostBlogScreenController extends GetxController{
  RxList<File> images = <File>[].obs;
  var textController = TextEditingController();

  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      images.addAll(pickedImages.map((XFile file) => File(file.path)));
    }
  }
  
  Clear() {
    images.clear();
  }

  Future<void> postBlog(String user_id) async {
    user_id ='f6ee03f6-55a3-4d03-9cd2-3a3e0450e352';
    List<String> uploadedImages = [];
    for (var image in images) {
      String? imageUrl = await SupabaseService.instance.uploadImage(image, user_id);
      if (imageUrl != null) {
        uploadedImages.add(imageUrl);
      }
    }

    Blog newBlog = Blog(
      blogId: 'f6ee03f6-55a3-4d03-9cd2-3a3e0450e350',
      userId: user_id,
      created_at: DateTime.now().toIso8601String(),
      //images: uploadedImages,
      content: textController.text,
    );

    await SupabaseService.instance.saveBlog(newBlog);
  }
}