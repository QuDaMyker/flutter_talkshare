import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/folder.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateNewListVocabController extends GetxController {
  RxList<TextEditingController> wordTCs = <TextEditingController>[].obs;
  RxList<Folder> listFolder = RxList.empty();
  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  Rx<Folder?> selectedFolder = Rx<Folder?>(null);
  TextEditingController folderTextCtrl = TextEditingController();
  TextEditingController nameTextCtrl = TextEditingController();
  Rx<File?> pickedImage = Rx<File?>(null);

  @override
  void onInit() async {
    super.onInit();
    currentUser = authController.user;

    wordTCs.add(TextEditingController(text: ""));
    listFolder.addAll(await SupabaseService.instance
        .getAllFolders(currentUser?.user_id ?? ''));
  }

  Future<void> onCreate() async {
    var wordsetId = Uuid().v4();
    WordSet wordSet = WordSet(
        wordsetId: wordsetId,
        name: nameTextCtrl.text,
        avatarUrl: pickedImage.value != null
            ? 'https://huprpremefnsrvgkdhqm.supabase.co/storage/v1/object/public/Wordset%20Avatar/' +
                await SupabaseService.instance.uploadImage(pickedImage.value!)
            : '',
        userId: currentUser?.user_id ?? '');
    List<String> words = wordTCs.map((element) => element.text).toList();
    SupabaseService.instance.addWordset(wordSet, words);
    return;
  }

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }
}
