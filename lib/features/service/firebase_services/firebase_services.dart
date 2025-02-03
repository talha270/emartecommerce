import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/consts/firebase_const.dart';
import 'package:emartecommerce/features/app/consts/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static getuserdata({required String uid}) {
    return FirebaseFirestore.instance
        .collection(userscollection)
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(); // .snapshots() returns a Stream<QuerySnapshot>
  }

  static getproducts({required String categories}) {
    return FirebaseFirestore.instance
        .collection(productscollection)
        .where("p_category", isEqualTo: categories)
        .snapshots();
  }

  static getcarts({required String uid}) {
    return firestore
        .collection(cartcollection)
        .where("added_by", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static deletefromcard({required id}) {
    return firestore.collection(cartcollection).doc(id).delete();
  }

  static getallmessages({required String docid}) {
    if (docid != null || docid != "" || docid.isNotEmpty) {
      return firestore
          .collection(chatscollection)
          .doc(docid)
          .collection(messagesCollection)
          .orderBy("created_on", descending: false)
          .snapshots();
    }
  }

  static getallorders() {
    return firestore
        .collection(ordercollaction)
        .where("order_by", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static getallwishlist() {
    return firestore
        .collection(productscollection)
        .where("p_wishlist",
            arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static getallusermessages() {
    return firestore
        .collection(chatscollection)
        .where("from_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static getcount() async {
    var res = await Future.wait([
      firestore
          .collection(cartcollection)
          .where("added_by", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
      firestore
          .collection(productscollection)
          .where("p_wishlist",
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
      firestore
          .collection(ordercollaction)
          .where("order_by", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
    ]);
    print(res);
    return res;
  }

  static getallproduct(){
    return firestore.collection(productscollection).snapshots();
  }

  static getfeaturedproduct(){
    return firestore.collection(productscollection).where("is_featured",isEqualTo: true).snapshots();
  }
}
