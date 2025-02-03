import 'dart:async';

import 'package:emartecommerce/features/auth_pages/pages/login_page.dart';
import 'package:emartecommerce/features/home/home.dart';
import 'package:get/get.dart';

import '../app/consts/firebase_const.dart';

class Getxsplashcontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    changescreen();
  }
  changescreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        auth.authStateChanges().listen(
          (user) {
            if (user == null) {
              Get.offAll(LoginPage());
            } else {
              Get.offAll(Home());
            }
          },
        );
      },
    );
  }
}
