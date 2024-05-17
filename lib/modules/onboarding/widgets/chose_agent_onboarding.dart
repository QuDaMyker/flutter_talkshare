import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/onboarding/controller/onboarding_controller.dart';
import 'package:get/get.dart';

class ChoseAgentBoarding extends StatelessWidget {
  const ChoseAgentBoarding({
    super.key,
    required this.title,
    required this.levels,
    required this.onSelect,
  });
  final String title;
  final List<Map<String, dynamic>> levels;
  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primary20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GroupItemAgent(
            levels: levels,
          )
        ],
      ),
    );
  }
}

class GroupItemAgent extends StatefulWidget {
  const GroupItemAgent({
    super.key,
    required this.levels,
  });
  final List<Map<String, dynamic>> levels;
  @override
  State<GroupItemAgent> createState() => _GroupItemAgentState();
}

class _GroupItemAgentState extends State<GroupItemAgent> {
  @override
  Widget build(BuildContext context) {
    final OnBoardingController onBoardingController =
        Get.find<OnBoardingController>();
    return Container(
      // height: 600,
      width: Get.width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          childAspectRatio: 2 / 1.6,
          mainAxisSpacing: 5, // spacing between rows
          crossAxisSpacing: 10, // spacing between columns
        ),
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: widget.levels.length, // total number of items
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemAgent(
            id: widget.levels[index]['id'],
            icon: widget.levels[index]['icon'],
            groupValue: onBoardingController.selectedAgent.value,
            onSelected: (p0) {
              setState(() {
                onBoardingController.onSelectedAgent(p0);
              });
            },
          );
        },
      ),
    );
  }
}

class ItemAgent extends StatefulWidget {
  const ItemAgent({
    Key? key,
    required this.id,
    required this.icon,
    required this.groupValue,
    required this.onSelected,
  }) : super(key: key);

  final int id;
  final String icon;
  final int groupValue;
  final Function(int) onSelected;

  @override
  State<ItemAgent> createState() => _ItemAgentState();
}

class _ItemAgentState extends State<ItemAgent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        widget.onSelected(widget.id);
      },
      child: Stack(
        children: [
          Container(
            // width: 150,
            // height: 115,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SvgPicture.asset(
                  widget.icon,
                  theme: SvgTheme(currentColor: Colors.white),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.id == widget.groupValue,
            child: Positioned(
              top: 8,
              right: 8,
              child: SvgPicture.asset(ImageAssets.icChecked),
            ),
          ),
        ],
      ),
    );
  }
}
