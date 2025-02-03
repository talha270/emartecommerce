import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:flutter/material.dart';

Widget orderplacedetail({required String title1,required String title2,required String d1,required String d2}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title1,style: TextStyle(fontFamily: semibold),),
          Text(d1,style: TextStyle(fontFamily: semibold,color: redColor),),
        ],
      ),
      SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title2,style: TextStyle(fontFamily: semibold),),
            Text(d2,style: TextStyle(color: Colors.grey),),
          ]
        ),
      )
    ],
  );
}
