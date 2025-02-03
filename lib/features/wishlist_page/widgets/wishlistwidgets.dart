import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../categories/item_detail_page.dart';

wishlistcontent(data,controller){
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                         Get.to(ItemDetailPage(
                           product: data[index],
                         ));
                        },
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                              imageUrl: data[index]["p_images"][0]),
                        ),
                        title: Text(
                          "${data[index]["p_name"]}",
                          style: TextStyle(
                              fontFamily: semibold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "${data[index]["p_price"]}".numCurrency,
                          style: TextStyle(
                              fontFamily: semibold, color: redColor),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              controller.removetowishlist(
                                  docid: data[index].id,
                                  context: context);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: redColor,
                            )),
                      ));
                },
              )),
        ],
      )
  );
}