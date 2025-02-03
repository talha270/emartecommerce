import 'package:emartecommerce/features/categories/widgets/imageslider.dart';
import 'package:emartecommerce/features/chat_messages/chat_page.dart';
import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import '../app/consts/colors.dart';
import '../app/consts/fontstyles.dart';
import '../app/consts/images.dart';
import '../app/consts/lists.dart';
import '../app/consts/strings.dart';
import '../app/global/widgets/custombutton.dart';
import '../provider_controller/getxchatcontroller.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({super.key, this.product});
  final dynamic product;

  var controller= Get.put(Getxproductcontroller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetvalues();
        return true;
      },
      child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                controller.resetvalues();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              product["p_name"],
              style: const TextStyle(fontFamily: bold, color: darkFontGrey),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              Obx(() => IconButton(
                  onPressed: () {
                    if (controller.isfav.value) {
                      controller.removetowishlist(
                          context: context, docid: product.id);
                    } else {
                      controller.addtowishlist(
                          context: context, docid: product.id);
                    }
                  },
                  icon: controller.isfav.value
                      ? Icon(
                          Icons.favorite,
                          color: redColor,
                        )
                      : const Icon(Icons.favorite_outline)))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageslider(product),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        product["p_name"],
                        style: const TextStyle(
                            fontSize: 16,
                            color: darkFontGrey,
                            fontFamily: semibold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VxRating(
                        isSelectable: false,
                        value: double.parse(product["p_rating"]),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                        stepInt: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${product["p_price"]}".numCurrency,
                        style: const TextStyle(
                            color: redColor, fontFamily: bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: textfieldGrey,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Seller",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontFamily: semibold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    product["p_seller"],
                                    style: const TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: whiteColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.message_rounded,
                                ),
                                color: darkFontGrey,
                                onPressed: () {
                                  final con=Get.put(Getxchatcontroller());
                                  con.setFriendNameAndId(
                                    name: product["p_seller"],
                                    id: product["vender_id"],
                                  );
                                  Get.to(ChatPage());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Colors: ",
                                      style: TextStyle(color: textfieldGrey),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: List.generate(
                                        product["p_color"].length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () => controller.colorindex.value = index,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(product["p_color"][index]).withOpacity(1.0),
                                                  ),
                                                ),
                                                Obx(
                                                      () => Visibility(
                                                    visible: index == controller.colorindex.value,
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                        },
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Quantity: ",
                                      style: TextStyle(color: textfieldGrey),
                                    ),
                                  ),
                                 Row(children: [
                                        IconButton(
                                            onPressed: () {
                                              if (controller.quantity > 0) {
                                                controller.quantity.value--;
                                              }
                                            },
                                            icon: const Icon(Icons.remove)),
                                        Obx(
                                          ()=>Text(
                                            "${controller.quantity}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: darkFontGrey,
                                                fontFamily: bold),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (int.parse(product["p_quantity"]) >
                                                  controller.quantity.value) {
                                                controller.quantity.value++;
                                              }
                                            },
                                            icon: const Icon(Icons.add)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "(${product["p_quantity"]} available)",
                                          style: const TextStyle(
                                              color: textfieldGrey),
                                        )
                                      ])
                                ],
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(8),
                                child:Row(
                                      children: [
                                        const SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Total: ",
                                            style:
                                                TextStyle(color: textfieldGrey),
                                          ),
                                        ),
                                        Obx(
                                          ()=> Text(
                                            "${controller.quantity.value * double.parse(product["p_price"])}"
                                                .numCurrency,
                                            style: const TextStyle(
                                                color: redColor,
                                                fontSize: 16,
                                                fontFamily: bold),
                                          ),
                                        )
                                      ],
                                    )
                                )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Description: ",
                                  style: TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: semibold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product["p_description"],
                                  style: const TextStyle(color: darkFontGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemdetailbuttonlist.length,
                          (index) {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(
                                  itemdetailbuttonlist[index],
                                  style: const TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey),
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    productsyoumaylike,
                                    style: TextStyle(
                                        fontFamily: bold,
                                        fontSize: 16,
                                        color: darkFontGrey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )),
             SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: customButton(
                        title: "Add to Card",
                        callback: () {
                          if (controller.quantity > 0) {
                            print("value of quantity is: ${controller.quantity}");
                            controller.addtocard(
                                venderid: product["vender_id"],
                                title: product["p_name"],
                                img: product["p_images"][0],
                                sellername: product["p_seller"],
                                color: product["p_color"][controller.colorindex.value],
                                qty: controller.quantity.value.toString(),
                                tprice:
                                    "${controller.quantity.value * double.parse(product["p_price"])}",
                                context: context);
                            VxToast.show(context, msg: "Added to Card");
                          } else {
                            VxToast.show(context, msg: "0 quantity");
                          }
                        },
                        bgcolor: redColor,
                        textcolor: whiteColor),
                  )
            ],
          )),
    );
  }
}
