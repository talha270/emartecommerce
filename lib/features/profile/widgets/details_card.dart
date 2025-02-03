import 'package:flutter/material.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';

detailscard({required double width,required String count,required String title}){
  return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: width,
          height: 80,
          child: Column(
            children: [
              Text(count,style: const TextStyle(fontFamily: bold,color: darkFontGrey,fontSize: 16),),
              const SizedBox(height: 5,),
              Text(title,style: const TextStyle(color: darkFontGrey),)
            ],
          ),
        ),
       ));
}
