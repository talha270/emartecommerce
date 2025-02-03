import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/consts/firebase_const.dart';

class Getxprofilecontroller extends GetxController {
  var imagpath = "".obs;
  var isloading = false.obs;


  pickimage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;
      imagpath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  updatename(
      {required String name,
      required String password,
      required String imgurl}) async {
    var store = await firestore
        .collection(userscollection)!
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({"name": name, "password": password, "imgurl": imgurl},
        SetOptions(merge: true));
  }

  changeauthpassword(
      {required String email,
      required String oldpassword,
      required String password}) async {
    final cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);

    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(cred)
        .then(
      (value) {
        FirebaseAuth.instance.currentUser!
            .updatePassword(password)
            .catchError((error) {
          print("error: $error");
        });
      },
    );
  }
}
