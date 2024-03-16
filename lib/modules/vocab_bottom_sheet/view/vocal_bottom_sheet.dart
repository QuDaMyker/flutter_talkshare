import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/vocal_bottom_sheet_controller.dart';
import 'package:get/get.dart';

class MyVocalBottom extends StatelessWidget {
  const MyVocalBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final VocalController controller = Get.put(VocalController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Test",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.01,
            horizontal: deviceWidth * 0.03,
          ),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(
                    () => Text('${controller.index.value}'),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.tang();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.showNackbar(context);
                    },
                    child: const Text('show snak bar'),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        controller.showBottomSheet(context);
                      },
                      icon: const Icon(Icons.add),
                      label: Text('text button'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
