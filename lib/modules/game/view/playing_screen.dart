import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/game/controllers/playing_controller.dart';
import 'package:get/get.dart';

import '../../../core/values/image_assets.dart';

class PlayingScreen extends StatelessWidget {
  PlayingScreen({super.key});
  final PlayingController controller = Get.put(PlayingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  width: 34,
                  height: 34,
                  child: SvgPicture.asset(
                    ImageAssets.icBack,
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              Spacer(),
              Text(
                'Bạn',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 12),
              Text(
                "5",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Spacer(),
              Text(
                "5",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(width: 12),
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageAssets.txtTurn),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.secondary90,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  '00:30',
                  style: TextStyle(
                      color: AppColors.primary40, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Expanded(child: Obx(() {
            return ListView.separated(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 12,
                            ),
                          ],
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(12))),
                      child: Text(
                        message['word'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '+4',
                      style: TextStyle(
                          color: AppColors.secondary60,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
            );
          })),
          MessageInputWidget()
        ],
      ),
    ));
  }

  Widget MessageInputWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD3D8DE),
                  width: 1,
                )),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    minLines: 1,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2731),
                    ),
                    onTap: () {},
                    onSubmitted: (value) => controller.sendMessage('userId'),
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller.textController,
                  builder: (context, textEditingValue, child) {
                    if (textEditingValue.text.trim().isNotEmpty) {
                      return SizedBox(
                        height: 32,
                        width: 32,
                        child: IconButton(
                          padding: const EdgeInsets.only(right: 8.0),
                          icon: SvgPicture.asset(
                            ImageAssets.icVideo,
                            width: 25,
                            height: 25,
                            color: const Color(0xFF1E2731),
                          ),
                          onPressed: textEditingValue.text.isNotEmpty
                              ? () => controller.sendMessage('userId')
                              : null,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
