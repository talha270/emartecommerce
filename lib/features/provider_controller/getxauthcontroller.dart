import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/consts/firebase_const.dart';

class Getxauthcontroller extends GetxController{
  var isloadinglogin=false.obs;
  var isloadingsignup=false.obs;
  RxBool ischeck = false.obs;


  Future<UserCredential?> loginmethod({required String email,required String password,required context})async{
    UserCredential ?userCredential;
    try{

      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      customsnackbar("Error in login", e.message.toString());
    }
    return userCredential;
  }


  Future<UserCredential?> signupmethod({required String email,required String password,required context})async{
    UserCredential ?userCredential;
    try{

      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeuserdata({required String name,required String email,required String password})async{

    DocumentReference store = await firestore.collection(userscollection).doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({"name":name,"email":email,"password":password,"imgurl":"","id":FirebaseAuth.instance.currentUser!.uid,"cart_count":"00","wishlist_count":"00","order_count":"00"});

  }

  signoutmethod(context)async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

}