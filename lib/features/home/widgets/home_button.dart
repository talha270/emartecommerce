import 'package:flutter/material.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';

homebutton({required VoidCallback onpressed,required double height,required double width,required String iconpath,required String title}){
  return GestureDetector(
    onTap: onpressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconpath,width: 26,),
          const SizedBox(height: 10),
          Text(title,style: const TextStyle(fontFamily: semibold,color: darkFontGrey),)
        ],
      ),
    ),
  );
}
