import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class VocalFolderScreen extends StatelessWidget {
  const VocalFolderScreen({super.key, required this.nameOfFolder});
  final String nameOfFolder;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(deviceHeight, deviceWidth),
    );
  }

  Padding _buildBody(double deviceHeight, double deviceWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.001,
        horizontal: deviceWidth * 0.03,
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 0.66,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Hero(
            tag: index,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
              padding: EdgeInsets.symmetric(
                vertical: deviceWidth * 0.01,
                horizontal: deviceWidth * 0.01,
              ),
              margin: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
                horizontal: deviceWidth * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: deviceHeight * 0.01,
                      ),
                      height: deviceWidth * 0.25,
                      width: deviceWidth * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              'https://images.unsplash.com/photo-1682686581660-3693f0c588d2?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceHeight * 0.01,
                      ),
                      child: const Text(
                        'Báo cáo tài chính',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        nameOfFolder,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
