import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:emartecommerce/features/wishlist_page/widgets/wishlistwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});
  final controller=Get.put(Getxproductcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "My Wishlist",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseServices.getallwishlist(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Wishlist yet",
                style: TextStyle(
                  color: darkFontGrey,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return wishlistcontent(data,controller);
          }
        },
      ),
    );
  }
}

