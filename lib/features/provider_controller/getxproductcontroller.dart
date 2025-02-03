import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/consts/firebase_const.dart';
import '../app/consts/lists.dart';

class Getxproductcontroller extends GetxController{
  // Getxproductcontroller(product);
  RxString selectedFilter= "All".obs;
  var colorindex = 0.obs;
  var quantity = 0.obs;
  List subcategories=[];
  getsubcategories(String categories){
    List s= categoriesitemsmap.where((element) => element["name"]==categories,).toList();
    if(s.isNotEmpty){
      subcategories=s[0]["subcategories"];
    }

  }
  var filteredProducts = [].obs;
  var allProducts = [];

  void updateProducts(List<DocumentSnapshot> products) {
    allProducts = products;
    filterProducts();
  }

  void filterProducts() {
    if (selectedFilter.value == "All") {
      filteredProducts.assignAll(allProducts);
    } else {
      filteredProducts.assignAll(
        allProducts.where((product) => product["p_subcategory"] == selectedFilter.value).toList(),
      );
    }
  }
  addtocard(
      {required String title,
        required String img,
        required String sellername,
        required int color,
        required String qty,
        required String tprice,
        required context,
        required String venderid}) async {
    await firestore.collection(cartcollection).doc().set({
      "title": title,
      "image": img,
      "sellername": sellername,
      "color": color,
      "quantity": qty,
      "vender_id":venderid,
      "totalprice": tprice,
      "added_by": FirebaseAuth.instance.currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }
  var isfav=false.obs;
  checkisfav(data){
    if(data["p_wishlist"].contains(FirebaseAuth.instance.currentUser!.uid)){
      isfav.value=true;
    }else{
      isfav.value= false;
    }
  }
  resetvalues() {
    isfav.value=false;
    colorindex.value = 0;
    quantity.value = 0;
  }
  addtowishlist({required docid,required context}) async {
    await firestore.collection(productscollection).doc(docid).set({
      "p_wishlist": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isfav.value=true;
    VxToast.show(context, msg: "Add favourite");
  }

  removetowishlist({required docid,required context}) async {
    await firestore.collection(productscollection).doc(docid).set({
      "p_wishlist": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isfav.value=false;
    VxToast.show(context, msg: "Remove favourite");
  }

}
