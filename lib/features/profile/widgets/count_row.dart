import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_card.dart';

countrow(countdata){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      detailscard(
          width: Get.size.width / 3.9,
          count: "${countdata[0]}",
          title: "In Your Card"),
      detailscard(
          width: Get.size.width / 3.8,
          count: "${countdata[1]}",
          title: "In Your WishList"),
      detailscard(
          width: Get.size.width / 3.9,
          count: "${countdata[2]}",
          title: "In Your Orders"),
    ],
  );
}