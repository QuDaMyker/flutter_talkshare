import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemCollectionVocal extends StatelessWidget {
  const ItemCollectionVocal({
    super.key,
    required this.image,
    required this.title,
    required this.isCreateButton,
    required this.onPressed,
  });
  final String image;
  final String title;
  final bool isCreateButton;
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
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.03,
        vertical: deviceHeight * 0.001,
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.gray60,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: AppColors.gray60,
                  width: 1,
                ),
                left: BorderSide(
                  color: AppColors.gray60,
                  width: 1,
                ),
                right: BorderSide(
                  color: AppColors.gray60,
                  width: 1,
                ),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
            ),
            child: isCreateButton
                ? SvgPicture.asset(
                    'assets/images/svg/ic_add.svg',
                    semanticsLabel: 'Add New Vocal Collection',
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const Image(
                      fit: BoxFit.contain,
                      image: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1682686581660-3693f0c588d2?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                  ),
          ),
          Text(
            isCreateButton ? 'Tạo bộ từ mới' : title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
