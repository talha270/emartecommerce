import 'package:emartecommerce/features/categories/categories_details.dart';
import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';

featurebutton({required String imagepath,required String title,required context}){
  return GestureDetector(
    onTap: () {
      Get.put(Getxproductcontroller()).getsubcategories(title);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesDetails(title: title,),));
    },
    child: Container(
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: whiteColor
      ),
      child: Row(
        children: [
          Image.asset(imagepath,fit: BoxFit.fill,width: 60,),
          const SizedBox(width: 10,),
          Text(title,style: const TextStyle(fontFamily: semibold,color: darkFontGrey),)
        ],
      ),
    ),
  );
}
