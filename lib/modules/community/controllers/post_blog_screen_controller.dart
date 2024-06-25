import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/blog.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/community/controllers/community_controller.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PostBlogScreenController extends GetxController{
  RxList<File> images = <File>[].obs;
  var textController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();
  final CommunityController controllerComm = Get.find<CommunityController>();

  @override
  void onInit() {
    super.onInit();
    images.clear();
    textController.clear(); 
  }

  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      images.addAll(pickedImages.map((XFile file) => File(file.path)));
    }
  }

  Future<void> postBlog() async {
    List<String> uploadedImages = [];
    var uuid = const Uuid();
    String blogid = uuid.v4();
    for (var image in images) {
      String? imageUrl = await SupabaseService.instance.uploadImage(image, authController.user.user_id);
      if (imageUrl != null) {
        uploadedImages.add(imageUrl);
      }
    }

    Blog newBlog = Blog(
      blogId: blogid,
      userId: authController.user.user_id,
      created_at: DateTime.now().toIso8601String(),
      images: uploadedImages,
      content: textController.text,
      fullname: authController.user.fullname,
      avatarUrl: authController.user.avatar_url,
    );

    await SupabaseService.instance.saveBlog(newBlog);

    images.clear();
    textController.clear(); 
    Get.back();
    controllerComm.getListBlog();
  }
}