// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemCheckBox extends StatefulWidget {
  const ItemCheckBox({
    Key? key,
    required this.id,
    required this.icon,
    required this.title,
    required this.groupValue,
    required this.onSelected,
  }) : super(key: key);

  final int id;
  final String icon;
  final String title;
  final int groupValue;
  final Function(int) onSelected;

  @override
  State<ItemCheckBox> createState() => _ItemCheckBoxState();
}

class _ItemCheckBoxState extends State<ItemCheckBox> {
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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.icon.isNotEmpty
                ? Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(widget.icon),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 4,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Radio(
                  activeColor: AppColors.secondary20,
                  groupValue: widget.groupValue,
                  value: widget.id,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
