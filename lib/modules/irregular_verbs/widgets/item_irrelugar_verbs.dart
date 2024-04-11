import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemIrregularVerbs extends StatelessWidget {
  const ItemIrregularVerbs ({
    super.key,
    required this.infinitive,
      required this.pastSimple,
      required this.pastParticiple,
      required this.meaning,    
  });

  final String infinitive;
  final String pastSimple;
  final String pastParticiple;
  final String meaning;   
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(            
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  
        children: [     
          Container(     
            width: 85.0,          
            height: 50.0,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5.0,),
            decoration: BoxDecoration(
              color: AppColors.gray60,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              infinitive,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray20,
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
            padding: EdgeInsets.symmetric(horizontal: 5.0,),
            decoration: BoxDecoration(
              color: AppColors.gray60,
              borderRadius: BorderRadius.circular(12.0),
            ),                
            child: Text(
              pastSimple,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray20,
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
            padding: EdgeInsets.symmetric(horizontal: 5.0,),
            decoration: BoxDecoration(
              color: AppColors.gray60,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              pastParticiple,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray20,
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
            padding: EdgeInsets.symmetric(horizontal: 5.0,),
            decoration: BoxDecoration(
              color: AppColors.gray60,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              meaning,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray20,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
          
        ],
    ),
      
  );
    
  }
}
