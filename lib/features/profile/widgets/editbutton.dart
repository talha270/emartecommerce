import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/consts/colors.dart';
import '../edit_profile_page.dart';

editbutton(data){
  return Align(
    alignment: Alignment.topRight,
    child: IconButton(
        onPressed: () {
         Get.to(EditProfilePage(data: data,));
        },
        icon: const Icon(
          Icons.edit,
          color: whiteColor,
        )),
  );
}