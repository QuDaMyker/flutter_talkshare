import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_talkshare/modules/onboarding/widgets/item_checkbox.dart';
import 'package:get/get.dart';

class ChoseLevelBoarding extends StatelessWidget {
  const ChoseLevelBoarding({
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
          GroupItemCheckBox(
            levels: levels,
          )
        ],
      ),
    );
  }
}

class GroupItemCheckBox extends StatefulWidget {
  const GroupItemCheckBox({
    super.key,
    required this.levels,
  });
  final List<Map<String, dynamic>> levels;
  @override
  State<GroupItemCheckBox> createState() => _GroupItemCheckBoxState();
}

class _GroupItemCheckBoxState extends State<GroupItemCheckBox> {
  @override
  Widget build(BuildContext context) {
    final OnBoardingController onBoardingController =
        Get.find<OnBoardingController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.gray40.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          ...widget.levels.mapIndexed((index, element) {
            return Column(
              children: [
                ItemCheckBox(
                  onSelected: (p0) {
                    setState(() {
                      onBoardingController.onSelectedLevel(p0);
                    });
                  },
                  groupValue: onBoardingController.selectedLevel.value,
                  id: element['id'],
                  icon: element['icon'],
                  title: element['title'],
                ),
                index == onBoardingController.listOnBoarding.length
                    ? Container()
                    : Divider(
                        color: AppColors.gray60,
                      ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
