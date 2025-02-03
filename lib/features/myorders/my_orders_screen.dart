import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/myorders/order_detail_page.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseServices.getallorders(),
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
                "No Orders yet",
                style: TextStyle(
                  color: darkFontGrey,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      "${index + 1}",
                      style: TextStyle(
                          fontFamily: bold, color: darkFontGrey, fontSize: 19),
                    ),
                    title: Text(
                      data[index]["order_code"],
                      style: TextStyle(color: redColor, fontFamily: semibold),
                    ),
                    subtitle: Text("${data[index]["total_amount"]}".numCurrency,
                        style: TextStyle(fontFamily: bold)),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(data: data[index],),));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        )),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
