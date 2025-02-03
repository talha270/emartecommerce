import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../app/consts/lists.dart';
import '../../chat_messages/messaging_page.dart';
import '../../myorders/my_orders_screen.dart';
import '../../wishlist_page/wishlist_page.dart';

listcolumn() {
  return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            switch (index) {
              case 0:
                Get.to(MyOrdersScreen());
                break;
              case 1:
Get.to( WishlistPage());
                break;
              case 2:
                Get.to(MessagingPage());
                break;
            }
          },
          leading: Image.asset(
            profilebuttonicon[index],
            width: 22,
          ),
          title: Text(
            profilebuttonlist[index],
            style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: lightGrey,
        );
      },
      itemCount: profilebuttonlist.length);
}
