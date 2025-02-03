import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_snackbar.dart';
import 'package:emartecommerce/features/app/global/widgets/custombutton.dart';
import 'package:emartecommerce/features/card/shipping_detail.dart';
import 'package:emartecommerce/features/provider_controller/getxcartcontroller.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CardPages extends StatelessWidget {
  const CardPages({super.key});
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(Getxcartcontroller());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Shopping Card",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseServices.getcarts(uid: FirebaseAuth.instance.currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty.",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.productssnapshot=data;
            controller.calcaulatetotal(data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                          child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                              imageUrl: data[index]["image"]),
                        ),
                        title: Text(
                          "${data[index]["title"]} (x${data[index]["quantity"]})",
                          style: TextStyle(fontFamily: semibold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "${data[index]["totalprice"]}".numCurrency,
                          style: TextStyle(fontFamily: semibold,color: redColor),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              FirebaseServices.deletefromcard(id: data[index].id);
                              customsnackbar("EMart", "Item removed form card.");
                            }, icon: Icon(Icons.delete,color: redColor,)),
                      ));
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: lightgolden,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total price",
                          style: TextStyle(
                              fontFamily: semibold, color: darkFontGrey),
                        ),
                        Text(
                            "${controller.totalprice}".numCurrency,
                            style: const TextStyle(
                                fontFamily: semibold, color: redColor),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: customButton(
                        title: "Proceed to Shipping",
                        callback: () {
                          Get.to( ShippingDetail());
                        },
                        bgcolor: redColor,
                        textcolor: whiteColor),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
