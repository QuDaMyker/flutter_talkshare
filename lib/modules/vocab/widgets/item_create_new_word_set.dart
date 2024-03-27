import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class ItemCreateNewWordset extends StatelessWidget {
  const ItemCreateNewWordset({
    super.key,
    required this.onPressed,
  });
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth * 0.45,
      margin: EdgeInsets.only(
        right: deviceWidth * 0.01,
      ),
      padding: EdgeInsets.only(
        right: deviceWidth * 0.01,
        left: deviceWidth * 0.01,
        bottom: deviceHeight * 0.001,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gray60,
          width: 1,
        ),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: deviceWidth * 0.03,
                  right: deviceWidth * 0.03,
                  top: deviceHeight * 0.01,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      //color: AppColors.gray60,
                      color: Colors.transparent,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/images/svg/ic_add.svg',
                  semanticsLabel: 'Add New Vocab Collection',
                ),
              ),
            ],
          ),
          const Text(
            'Tạo bộ từ mới',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
