import 'package:flutter_talkshare/modules/idioms/services/idioms_services.dart';
import 'package:get/get.dart';

class IdiomsScreenController extends GetxController{
  var isLoading = Rx<bool>(false);
  var listIdioms = Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() async {
    isLoading.value = true;
    await getListIdioms();

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListIdioms() async {
    listIdioms.value = await IdiomsServices().getIdiomsList();
  }
}