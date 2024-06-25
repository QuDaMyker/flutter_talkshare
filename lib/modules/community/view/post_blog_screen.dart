import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/community/controllers/post_blog_screen_controller.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:get/get.dart';

class PostBlogScreen extends StatelessWidget {
  PostBlogScreen({super.key});

  final PostBlogScreenController controller = Get.put(PostBlogScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: button(context),
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [          
          SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
            child: Row(children: [
              InkWell(
                onTap: () => controller.pickImages(),
                child:  Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 0.5, style: BorderStyle.solid),
                  ),                      
                  child: ClipRRect(
                    child: SvgPicture.asset(ImageAssets.icAdd2),
                    ),
                ),
              ),  

              const SizedBox(
                width: 5,
              ),       

              Expanded(child: 
                SizedBox(
                height: 85,
                child: Obx (
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.images.length,
                    itemBuilder: (context, index) {
                      return PhotoItem(
                        controller.images[index],
                        onDelete:() {
                          controller.images.removeAt(index);
                        },);
                    },
                  ),
                ),
              ),
              ),
            ],)
          ),

          const SizedBox(
            height: 12,
          ),           
          const Text(
            "Nội dung",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),

          const SizedBox(
            height: 5,
          ), 

          Container(
            height: 255,
            child: TextField(
              controller: controller.textController,
              maxLines: null, 
              keyboardType: TextInputType.multiline, 
              minLines: 9,              
              decoration: InputDecoration(
                hintText: 'Nhập văn bản của bạn...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0), 
                  borderSide: BorderSide(color: Colors.black, width: 1), 
                ),
              ),
            ),
          ), 
        ],
      ),
    );
  }

  InkWell button(BuildContext context,) {
    return InkWell( 
      onTap: () => controller.postBlog(),
      child: Container(
        width: 380,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.secondary20,
          borderRadius: BorderRadius.circular(12)),
        child:const Text(
          "Đăng",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget PhotoItem(File imageFile, {required void Function() onDelete}) {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                imageFile,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover, // or BoxFit.contain
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onDelete,
              child: SvgPicture.asset(ImageAssets.icRemove),
            ),
          ),
        ],
      ),
    );
  }


  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          controller.images.clear();
          controller.textController.clear(); 
          Get.back();
        },
      ),

      centerTitle: true,
      title: const Text(
        'Đăng Blog',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(3.0),
        child: Container(
          color: AppColors.gray60,
          height: 1.3,
        ),
      ),
    );
  }
}