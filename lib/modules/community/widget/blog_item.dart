import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/blog.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/community/widget/image_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ItemBlog extends StatelessWidget {
  final Blog blog;
  const ItemBlog({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      // height: 420,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(blog.avatarUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icStar),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "Teacher",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondary20),
                            )
                          ],
                        ),
                        Text(
                          blog.fullname,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                blog.created_at,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ExpandableText(
            blog.content,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            expandText: 'Xem thêm',
            collapseText: 'Thu gọn',
            maxLines: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          _buildGrid(context),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    List<String> images = blog.images;
    int count = images.length;
    List<Widget> children = [];
    if (count == 1) {
      children.add(_buildImage(context, 0, images[0], true, false));
    } else if (count == 2) {
      children.add(_buildImage(context, 0, images[0], false, true));
      children.add(_buildImage(context, 0, images[1], false, true));
    } else if (count == 3) {
      children.add(
        Column(
          children: [
            _buildImage(context, 0, images[0], false, true),
            Row(
              children: [
                Expanded(child: _buildImage(context, 0, images[1], true, true)),
                Expanded(child: _buildImage(context, 0, images[2], true, true)),
              ],
            ),
          ],
        ),
      );
    } else if (count == 4) {
      children.add(
        Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildImage(context, 0, images[0], true, true)),
                Expanded(child: _buildImage(context, 1, images[1], true, true)),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buildImage(context, 2, images[2], true, true)),
                Expanded(child: _buildImage(context, 3, images[3], true, true)),
              ],
            ),
          ],
        ),
      );
    } else if (count > 4) {
      children.add(
        Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildImage(context, 0, images[0], true, true)),
                Expanded(child: _buildImage(context, 1, images[1], true, true)),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buildImage(context, 2, images[2], true, true)),
                Expanded(
                    child:
                        _buildDarkenedImage(context, 3, images[3], true, true)),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildImage(BuildContext context, int index, String url,
      bool fullWidth, bool halfHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageGallery(images: blog.images, initialIndex: index),
          ),
        );
      },
      child: Container(
        width: fullWidth ? double.infinity : 330.0,
        height: halfHeight ? 150.0 : 300.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildDarkenedImage(BuildContext context, int index, String url,
      bool fullWidth, bool halfHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageGallery(images: blog.images, initialIndex: index),
          ),
        );
      },
      child: Container(
        width: fullWidth ? double.infinity : 330.0,
        height: halfHeight ? 150.0 : 300.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            '+${blog.images.length - 4}',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
