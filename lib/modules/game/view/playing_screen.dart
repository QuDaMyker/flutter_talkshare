import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/game/controllers/playing_controller.dart';
import 'package:flutter_talkshare/modules/game/formatter.dart';
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
              Obx(() => Text(
                    controller.peerScore.value.toString(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
              Spacer(),
              Obx(() => Text(
                    controller.myScore.value.toString(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
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
          Obx(() => controller.isMyTurn.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.txtTurn),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.secondary90,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        '00:${controller.remainingSeconds.value.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            color: AppColors.primary40,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                )
              : SizedBox()),
          Expanded(child: Obx(() {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        message['user_id'] != controller.currentUser?.user_id
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      message['user_id'] != controller.currentUser?.user_id
                          ? SizedBox()
                          : Text(
                              '+ ${message['word'].toString().trim().length.toString()}',
                              style: TextStyle(
                                  color: AppColors.secondary60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                      SizedBox(
                        width: message['user_id'] !=
                                controller.currentUser?.user_id
                            ? 0
                            : 12,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 2),
                                blurRadius: 12,
                              ),
                            ],
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: message['user_id'] ==
                                    controller.currentUser?.user_id
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(0))
                                : BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(12))),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: message['word']
                                    .substring(0, message['word'].length - 1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: message['word']
                                    .substring(message['word'].length - 1),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: message['user_id'] ==
                                controller.currentUser?.user_id
                            ? 0
                            : 12,
                      ),
                      message['user_id'] == controller.currentUser?.user_id
                          ? SizedBox()
                          : Text(
                              '+ ${message['word'].toString().trim().length.toString()}',
                              style: TextStyle(
                                  color: AppColors.secondary60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )
                    ],
                  ),
                );
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
                  child: Obx(() => TextField(
                        enabled: controller.isMyTurn.value,
                        inputFormatters: [
                          OnlyLettersFormatter(),
                          if (controller.lastMessage.value.isNotEmpty)
                            FixedFirstCharacterFormatter(
                              controller.lastMessage.value[
                                  controller.lastMessage.value.length - 1],
                            ),
                        ],
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
                        onSubmitted: (value) => controller.sendMessage(),
                        controller: controller.textController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập tin nhắn',
                          border: InputBorder.none,
                        ),
                      )),
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
                              ? () => controller.sendMessage()
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
