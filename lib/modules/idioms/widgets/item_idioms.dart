import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemIdioms extends StatelessWidget{
  const ItemIdioms({
    super.key, 
    required this.idioms,
    required this.translatedIdioms,
  });

  final String idioms;
  final String translatedIdioms;

  @override
  Widget build(BuildContext context){
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight * 0.01,
      ),
      margin: EdgeInsets.only(
        bottom: deviceHeight * 0.01,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondary60,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        shape: BoxShape.rectangle,        
      ),
      child: Column(        
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIdioms(),
          _buildTranslatedIdioms(),
        ],
      ),
    );

  }

  Align _buildIdioms(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        idioms,
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
        translatedIdioms,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.primary40,       
          decoration: TextDecoration.none,   
        ),        
        textAlign: TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}