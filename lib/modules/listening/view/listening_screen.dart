import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/controller/listening_screen_controller.dart';
import 'package:flutter_talkshare/modules/listening/widgets/item_listening.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ListeningScreen extends StatelessWidget {
  ListeningScreen({Key? key}) : super(key: key);  
  ListeningScreenController listeningScreenController = Get.put(ListeningScreenController());

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth,listeningScreenController,)
      ),
    );
  }

 Container _buildBody (
    double deviceHeight,
    double deviceWidth,
    ListeningScreenController controller,
  ) {
    return Container(
      height: deviceHeight* 0.9,
          padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
                vertical: deviceHeight* 0.02,
              ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, AppColors.gray60],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ExpandablePanel(
                    header: Text(
                      'Short Stories',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary20,
                        fontSize: 16.0,
                      ),
                    ),
                    collapsed: SizedBox.shrink(),
                    expanded: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ListeningList.listeningShortList.length,
                      itemBuilder: (context, index) {
                        Listening item = ListeningList.listeningShortList[index];
                        return ItemListening(
                          listening: item,
                        );
                      },
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: true,
                      iconColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  ExpandablePanel(
                    header: Text(
                      'Daily Conversations',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary20,
                        fontSize: 16.0,
                      ),
                    ),
                    collapsed: SizedBox.shrink(),
                    expanded: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ListeningList.listeningDailyList.length,
                      itemBuilder: (context, index) {
                        Listening item = ListeningList.listeningDailyList[index];
                        return ItemListening(
                          listening: item,
                        );
                      },
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: true,
                      iconColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  ExpandablePanel(
                    header: Text(
                      'TOEIC Listening',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary20,
                        fontSize: 16.0,
                      ),
                    ),
                    collapsed: SizedBox.shrink(),
                    expanded: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ListeningList.listeningToeicList.length,
                      itemBuilder: (context, index) {
                        Listening item = ListeningList.listeningToeicList[index];
                        return ItemListening(
                          listening: item,
                        );
                      },
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: true,
                      iconColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    
  }

  AppBar _buildAppBar(
    BuildContext context
  ) {
    return AppBar(
      leading: IconButton(          
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          Navigator.pop(context); 
        },
      ),

      centerTitle: true,
      title: const Text (
        'Bài nghe',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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