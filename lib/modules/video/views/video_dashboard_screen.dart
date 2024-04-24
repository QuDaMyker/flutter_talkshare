import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/video/controllers/video_dashboard_controller.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/widgets/item_channel.dart';
import 'package:flutter_talkshare/modules/video/widgets/item_video.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VideoDashBoardScreen extends StatefulWidget {
  const VideoDashBoardScreen({super.key});

  @override
  State<VideoDashBoardScreen> createState() => _VideoDashBoardScreenState();
}

class _VideoDashBoardScreenState extends State<VideoDashBoardScreen>
    with SingleTickerProviderStateMixin {
  List<String> titles = [
    'Nổi bật',
    'Kênh',
  ];

  static List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Nổi bật',
    ),
    const Tab(text: 'Kênh'),
  ];

  late TabController _tabController;
  VideoDashBoardController videoDashBoardController =
      Get.put(VideoDashBoardController());

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, videoDashBoardController),
      ),
    );
  }

  Widget _buildBody(double deviceHeight, double deviceWidth,
      VideoDashBoardController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buidCustomTabbar(deviceHeight),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 10,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPopular(deviceHeight, deviceWidth, controller),
                _buildChannel(deviceHeight, deviceWidth, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannel(
    double deviceHeight,
    double deviceWidth,
    VideoDashBoardController controller,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded(
          //   flex: 0,
          //   child: _buildSearchField(controller),
          // ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 12,
            child: Obx(
              () => controller.isLoading.value
                  ? _buildLoading()
                  : ListView.builder(
                      itemCount: controller.channels.value.length,
                      itemBuilder: (context, index) {
                        ChannelModel channelModel =
                            controller.channels.value[index];
                        return ItemChannel(
                          channelModel: ChannelModel(
                            id: channelModel.id,
                            imgUrlBrand: channelModel.imgUrlBrand,
                            nameOfBrand: channelModel.nameOfBrand,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(VideoDashBoardController controller) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: AppColors.primary40),
          bottom: BorderSide(width: 1, color: AppColors.primary40),
          left: BorderSide(width: 1, color: AppColors.primary40),
          right: BorderSide(width: 1, color: AppColors.primary40),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        onFieldSubmitted: (value) {
          controller.searchValue.value = value;
        },
        onChanged: (value) {
          controller.searchValue.value = value;
        },
        cursorColor: AppColors.primary40,
        decoration: InputDecoration(
          hintText: ' Tìm kiếm kênh',
          hintStyle: const TextStyle(
            color: AppColors.primary40,
          ),
          contentPadding: const EdgeInsets.all(0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.primary40,
            ),
          ),
          suffixIcon: Obx(
            () => Visibility(
              visible: controller.searchValue.value.isNotEmpty ? true : false,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(ImageAssets.icClose),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopular(
    double deviceHeight,
    double deviceWidth,
    VideoDashBoardController controller,
  ) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: Obx(
          () => controller.isLoading.value
              ? _buildLoading()
              : ListView.builder(
                  itemCount: controller.popularVideos.value.length,
                  itemBuilder: (context, index) {
                    VideoModel videoModel =
                        controller.popularVideos.value[index];
                    return ItemVideo(
                      videoModel: VideoModel(
                        id: videoModel.id,
                        title: videoModel.title,
                        urlVideo: videoModel.urlVideo,
                        thumbnail: videoModel.thumbnail,
                        duration: videoModel.duration,
                        channel: videoModel.channel,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _buidCustomTabbar(double deviceHeight) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(
          top: 8,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.gray60,
          borderRadius: BorderRadius.circular(8),
        ),
        height: deviceHeight * 0.07,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          isScrollable: false,
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: AppColors.gray20,
          unselectedLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          automaticIndicatorColorAdjustment: true,
          indicator: const BoxDecoration(
            color: AppColors.secondary20,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          tabs: myTabs,
        ),
      ),
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: AppColors.primary40,
        rightDotColor: AppColors.secondary20,
        size: 20,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Video',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
