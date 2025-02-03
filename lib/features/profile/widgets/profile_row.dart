import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../app/consts/images.dart';
import '../../auth_pages/pages/login_page.dart';

profilerow(data,controller){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:  data["imgurl"]==""?AssetImage(profile_defauld):NetworkImage(data["imgurl"]),
          // child:,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data["name"]}",
                  style: TextStyle(
                      fontFamily: semibold, color: whiteColor),
                ),
                Text(
                  "${data["email"]}",
                  style: TextStyle(color: whiteColor),
                ),
              ],
            )),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: whiteColor,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              controller.changeindex(index1: 0);
              FirebaseAuth.instance.signOut();
              Get.offAll( LoginPage());
            },
            child: const Text(
              "LogOut",
              style: TextStyle(
                  fontFamily: semibold, color: whiteColor),
            ))
      ],
    ),
  );
}