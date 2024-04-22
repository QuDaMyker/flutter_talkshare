import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostBlogScreenController extends GetxController{
  RxList<File> images = <File>[].obs;

  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      images.addAll(pickedImages.map((XFile file) => File(file.path)));
    }
  }
  
  Clear() {
    images.clear();
  }

}