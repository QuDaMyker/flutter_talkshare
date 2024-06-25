import 'dart:io';
import 'package:flutter/material.dart';
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

  // Future<void> _postBlog() async {
  //   String content = textController.text;
  //   List<String> imageUrls = [];

  //   try {
  //     for (var imageFile in images) {
  //       final bytes = await imageFile.readAsBytes();
  //       final fileName = basename(imageFile.path);
  //       final response = await Supabase.instance.client.storage
  //           .from('images')
  //           .uploadBinary(fileName, bytes);

  //       final publicUrlResponse = await Supabase.instance.client.storage
  //           .from('images')
  //           .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10); // 10 years

  //       if (publicUrlResponse.error != null) {
  //         throw publicUrlResponse.error!;
  //       }

  //       imageUrls.add(publicUrlResponse.data!);
  //     }

  //     final response = await Supabase.instance.client.from('posts').insert({
  //       'content': content,
  //       'images': imageUrls,
  //     }).execute();

  //     if (response.error != null) {
  //       throw response.error!;
  //     }

  //     Get.snackbar('Success', 'Post uploaded successfully');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

}