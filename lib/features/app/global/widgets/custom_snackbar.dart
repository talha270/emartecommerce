import 'package:flutter/material.dart';
import 'package:get/get.dart';

customsnackbar(title, message) {
  return Get.snackbar(
    title,
    message,
    borderRadius: 12,
    margin: EdgeInsets.all(12),
    duration: Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
