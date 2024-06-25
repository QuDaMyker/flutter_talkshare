import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemCollectionVocab extends StatelessWidget {
  const ItemCollectionVocab({
    super.key,
    required this.onPressed,
    required this.wordSet,
  });
  final WordSet wordSet;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
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
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200,
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
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            wordSet.avatarUrl,
                            maxWidth: 100,
                            maxHeight: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppColors.primaryGradient,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        wordSet.count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              wordSet.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
