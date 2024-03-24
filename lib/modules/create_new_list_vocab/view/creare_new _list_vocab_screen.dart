import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';

class CreateNewListVocabScreen extends StatelessWidget{
  const CreateNewListVocabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: _buildAppBar(),
      body: _builBody(deviceHeight, deviceWidth),
      ),
    );
  }
  
  AppBar _buildAppBar() {
     return AppBar(
      centerTitle: true,
      title: const Text(
        'Tạo bộ từ mới',
          style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      leading:
        InkWell(
          child: SvgPicture.asset(ImageAssets.icBack, width: 4, height: 4,),         
          onTap: (){},
        ),
    );
  }
  
  Padding _builBody( double deviceHeight, double deviceWidth,) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceHeight*0.02, horizontal: deviceWidth*0.05),
      child: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: Colors.amber,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(                
                  width: deviceWidth,
                  height: deviceHeight *0.16,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    
                  ),
                ),
                Positioned(
                  left: deviceWidth*0.3,
                  child: Container(
                  width: deviceWidth*0.3,
                  height: deviceWidth*0.3,                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                     image: AssetImage(ImageAssets.imageFish), fit: BoxFit.cover),
                  ),
                ),),

                Positioned(
                  top: deviceHeight*0.12,
                  child: InkWell(
                  child: SvgPicture.asset(ImageAssets.icCamera),
                              onTap: () {},
                ),),              
              ],
            ),
            const SizedBox( height: 32,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Tên bộ từ',
                labelStyle:  const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary20,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(ImageAssets.icEdit),
                ),
                focusedBorder: customBorderWhenFocus(),
                border: customBorder(),
              ),
            ),
            const SizedBox(height: 12,),
            const Text('Bạn chỉ cần nhập từ, Talk Share sẽ tự động lấy nghĩa và ví dụ cho bạn',
            style: TextStyle(
              color: AppColors.gray40,
              fontSize: 14,
              fontWeight: FontWeight.w500,

            ),),
            const SizedBox(height: 12,),
            TextField(
              decoration: InputDecoration(
                labelText: 'agenda',
                labelStyle:  const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary20,
                ),
                focusedBorder: customBorderWhenFocus(),
                border: customBorder(),
                
              ),
            ),

            const SizedBox(height: 12,),
            TextField(
              decoration: InputDecoration(
                labelText: 'goal',
                labelStyle:  const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary20,
                ),
                focusedBorder: customBorderWhenFocus(),
                border: customBorder(),
              ),
            ),

            const SizedBox(height: 12,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Tên bộ từ',
                labelStyle:  const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary20,
                ),
                focusedBorder: customBorderWhenFocus(),
                border: customBorder(),
              ),
            ),

          ]
        )
      )
            
    );
  }
  OutlineInputBorder customBorder(){
    return OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.gray40,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                );
  }
   OutlineInputBorder customBorderWhenFocus(){
    return OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primary20,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                );
  }

}