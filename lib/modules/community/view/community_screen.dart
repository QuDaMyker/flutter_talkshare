import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/enums/community_tab.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/community/controllers/community_controller.dart';
import 'package:get/get.dart';

class CommnityScreen extends StatelessWidget {
  CommnityScreen({super.key});
  CommunityController controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() => Row(
                  children: [
                    Expanded(
                        child: ToggleButton(type: CommunityTab.INTERACTION)),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(child: ToggleButton(type: CommunityTab.BLOG)),
                  ],
                )),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.icMicrophone),
                const SizedBox(
                  width: 4,
                ),
                const Expanded(
                    child: Text(
                  "Phòng nói",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primary20,
                      fontWeight: FontWeight.w700),
                )),
                InkWell(
                  child: SvgPicture.asset(ImageAssets.icFilter),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AudioRoomItem();
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: 2)),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.icLivestream),
                const SizedBox(
                  width: 4,
                ),
                const Expanded(
                    child: Text(
                  "Livestream",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primary20,
                      fontWeight: FontWeight.w700),
                )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Free room early",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "7",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(ImageAssets.icUsersWhite)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "20 phút trước",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              color: AppColors.secondary20,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            "Tham gia",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ToggleButton({required CommunityTab type}) {
    bool isSelected = controller.selectedTab.value == type;
    return InkWell(
      onTap: () {
        controller.selectedTab.value = type;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary20 : AppColors.gray80,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          type.getName(),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.gray20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget AudioRoomItem() {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 8,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icUnlock),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Công khai",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                "7",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary40),
              ),
              const SizedBox(
                width: 4,
              ),
              SvgPicture.asset(ImageAssets.icUsersGreen)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Free room early",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary20),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "What did you do yesterday?",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.gray20),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 8,
              ),
              const Expanded(
                child: Text(
                  "20 phút trước",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray40),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.secondary20,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Tham gia",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Cộng đồng',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),
    );
  }
}
