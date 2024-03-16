import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_item_controller.dart';
import 'package:get/get.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key, required this.word});
  final String word;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final BottomSheetItemController controller =
        Get.put(BottomSheetItemController(word: word));

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                color: Colors.yellow,
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                  left: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                  right: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(20),
                ),
                shape: BoxShape.rectangle,
              ),
              width: deviceWidth,
              child: Padding(
                padding: EdgeInsets.all(
                  deviceWidth * 0.01,
                ),
                child: Column(
                  children: [
                    Text(word),
                    ElevatedButton(
                        onPressed: () async {
                          await controller.getWord('Trace');
                        },
                        child: const Text('Speaker')),
                    Text(controller.data.value),
                  ],
                ),
              ),
            ),
    );
  }
}
