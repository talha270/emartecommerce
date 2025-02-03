import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../app/consts/firebase_const.dart';
import '../app/consts/strings.dart';
import 'getxhomecontroller.dart';

class Getxcartcontroller extends GetxController{
  double totalprice=0;
  var placeorder=false.obs;
  var paymentmethodindex=0.obs;
  late dynamic productssnapshot;
  var products=[];
  var vendors=[];
  calcaulatetotal(dynamic data){
    totalprice=0;
    for(int i=0;i<data.length;i++){
      totalprice=totalprice +double.parse(data[i]["totalprice"]);
    }
  }
  placemyorder({required String address,required String totalamount,required String paymentmethod,required String postalcode,required String state,required String phone,required String city})async{
    placeorder.value=true;
    await getproductdetailforseller();
    await firestore.collection(ordercollaction).doc().set({
      "order_by":FirebaseAuth.instance.currentUser!.uid,
      "order_by_name":Getxhomecontroller.username.value,
      "order_by_email":FirebaseAuth.instance.currentUser!.email,
      "order_by_address":address,
      "order_by_state":state,
      "order_by_city":city,
      "order_by_phone":phone,
      "order_by_postalcode":postalcode,
      "shipping_method":"Home Delivery",
      "payment_method":paymentmethod,
      "order_placed":true,
      "order_code":"2423332",
      "order_date":FieldValue.serverTimestamp(),
      "order_confirmed":false,
      "order_delivered":false,
      "order_on_delivery":false,
      "total_amount":totalamount,
      "orders":FieldValue.arrayUnion(products),
      "vendors":FieldValue.arrayUnion(vendors)
    });
    placeorder.value=false;
  }
  getproductdetailforseller(){
    products.clear();
    vendors.clear();
    for(int i=0;i<productssnapshot.length;i++){
      products.add({
        "color":productssnapshot[i]["color"],
        "image":productssnapshot[i]["image"],
        "vender_id":productssnapshot[i]["vender_id"],
        "total_price":productssnapshot[i]["totalprice"],
        "quantity":productssnapshot[i]["quantity"],
        "title":productssnapshot[i]["title"]
      });
      vendors.add(productssnapshot[i]["vender_id"]);
    }
  }
  clearcard(){
    for(int i=0;i<productssnapshot.length;i++){
      FirebaseFirestore.instance.collection(cartcollection).doc(productssnapshot[i].id).delete();
    }
  }
}
