import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app/consts/firebase_const.dart';

class Getxhomecontroller extends GetxController{
  @override
  void onInit() {
    getusername();
    super.onInit();
  }
  var index=0;
  static var username="".obs;

  final PageController pagecontroller=PageController();

  void changeindex({required int index1}){
    index=index1;
    pagecontroller.jumpToPage(index);
    update();
  }
  getusername()async{
    var n=await firestore.collection(userscollection).where("id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        // print("first: ${value.docs.single["name"]}");
        // print("first: ${value.docs[0]["name]}");
        return value.docs.single["name"];
      }
    },);
    username.value=n;

  }

}
