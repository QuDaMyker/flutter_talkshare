import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/view/listening_read_screen.dart';
import 'package:flutter_talkshare/modules/listening/view/listening_write_screen.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ItemListening extends StatelessWidget{

  const ItemListening({
    super.key, 
    required this.listening,
  });

  final Listening listening;

  @override
  Widget build(BuildContext context){
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption('Nghe và đọc', () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListeningReadScreen(listening: listening,)
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              _buildOption('Nghe chép chính tả', () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListeningWriteScreen(listening: listening,)
                  ),
                );
              }),
            ],),
          ),
        );
      },

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 1,
        ),
        margin: EdgeInsets.only(
          bottom: deviceHeight * 0.01,
        ),
        decoration: const BoxDecoration(
          color: AppColors.secondary60,
          borderRadius: BorderRadius.all(
            Radius.circular(12,),
          ),
          shape: BoxShape.rectangle,        
        ),
        child: ListTile(
          leading: SvgPicture.asset(ImageAssets.icItemPlay),
          title: _buildName(),
          subtitle: _buildTranslatedIdioms(),
        ),
      ),
    );
  }

  Align _buildName(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        listening.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: AppColors.primary20,      
          decoration: TextDecoration.none,         
        ),        
        textAlign: TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Align _buildTranslatedIdioms(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        formatDuration(listening.time),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: AppColors.gray20,       
          decoration: TextDecoration.none,   
        ),        
        textAlign: TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildOption(String title, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.secondary20,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String formatDuration(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    String result ="";
    if (minutes!=0) result+='$minutes phút ';
    if (seconds!=0) result+='$seconds giây';
    return result;
  }
}