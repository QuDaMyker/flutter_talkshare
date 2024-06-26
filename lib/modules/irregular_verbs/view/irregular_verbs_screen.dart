import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/irregular_verb.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/irregular_verbs/controller/irregular_verbs_controller.dart';
import 'package:flutter_talkshare/modules/irregular_verbs/widgets/item_irrelugar_verbs.dart';
import 'package:get/get.dart';

class IrregulerVerbs extends StatelessWidget {
  const IrregulerVerbs({super.key});
    
  
  @override
  Widget build(BuildContext context){
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final IrregularVerbScreenController controller = Get.put(IrregularVerbScreenController());
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth, controller),
      ),
    );
  }

  Container _buildBody(
    double deviceHeight,
    double deviceWidth,
    IrregularVerbScreenController controller
    //
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight *0.02,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.gray60],
        ),
      ),
      child: Column(
        children: [
          TextField (
            textInputAction: TextInputAction.search,
            style:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            controller: controller.searchTextController,
            onChanged: controller.onChangeSearchText,
            decoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.gray40),              
              ),            
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(ImageAssets.icSearch),
              ),
              hintText: "Tìm kiếm",
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray20,
                  fontSize: 16.0),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),            
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: Obx(() => Visibility( 
                visible: controller.showSuffixIcon.value,
                child: GestureDetector(
                  onTap: () {
                   controller.clearSearchText();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(ImageAssets.icClose),
                  ),
                ),
              )),
              suffixIconConstraints:const  BoxConstraints(),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Row(                    
            mainAxisAlignment: MainAxisAlignment.spaceBetween,    
            children: [     
              Container(     
                width: 85.0,          
                height: 50.0,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: BoxDecoration(
                  color: AppColors.secondary20,
                  borderRadius: BorderRadius.circular(12.0),
                ),                
                child: const Text(
                  "Động từ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),

              Container(
                width: 85.0,          
                height: 50.0,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.0,),
                decoration: BoxDecoration(
                  color: AppColors.secondary20,
                  borderRadius: BorderRadius.circular(12.0),
                ),                
                child: const Text(
                  "Quá khứ đơn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),

              Container(
                width: 85.0,       
                height: 50.0,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.0,),
                decoration: BoxDecoration(
                  color: AppColors.secondary20,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  "Quá khứ phân từ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),                  
                  maxLines: 2,
                ),
              ),

              Container(
                width: 85.0,       
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondary20,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  "Nghĩa",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          Expanded(child: Obx(()=> SingleChildScrollView(      
            child: SizedBox(
              height: deviceHeight * 0.7,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                scrollDirection: Axis.vertical,
                itemCount: controller.searched_list.length,
                itemBuilder: (context, index) {
                  IrregularVerb verb = controller.searched_list[index];
                  return ItemIrregularVerbs(
                    infinitive: verb.infinitive,
                    pastSimple: verb.pastSimple,
                    pastParticiple: verb.pastParticiple,
                    meaning: verb.meaning,
                  );
                },
              ),
            ),  
          )),
          ),
        ],
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
        'Động từ bất quy tắc',
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