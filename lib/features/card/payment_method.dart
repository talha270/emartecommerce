import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/app/consts/lists.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/global/widgets/custombutton.dart';
import '../provider_controller/getxcartcontroller.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod(
      {super.key,
      required this.address,
      required this.postalcode,
      required this.state,
      required this.phone,
      required this.city});
  final String address, postalcode, state, phone, city;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Getxcartcontroller());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            "Choose Payment Method",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ),
        body: Obx(() => Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(5),
              child: Column(
                  children: List.generate(
                paymentmethodsimg.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.paymentmethodindex.value = index;
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: controller.paymentmethodindex.value == index
                                  ? redColor
                                  : Colors.transparent,
                              width: 2)),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentmethodsimg[index],
                            colorBlendMode:
                                controller.paymentmethodindex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentmethodindex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          controller.paymentmethodindex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: CircleBorder(),
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                          Positioned(
                              bottom: 0,
                              right: 10,
                              child: Text(
                                paymentmethodsname[index],
                                style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              )),
            )),
        bottomNavigationBar:Obx(()=> controller.placeorder.value
            ? SizedBox(
            height: 50,
            child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                )))
            : SizedBox(
            height: 50,
            child: customButton(
                title: "Place my order",
                callback: () async {
                  await controller.placemyorder(
                      address: address,
                      totalamount: controller.totalprice.toString(),
                      paymentmethod:
                      paymentmethodsname[controller.paymentmethodindex.value],
                      postalcode: postalcode,
                      state: state,
                      phone: phone,
                      city: city);
                  await controller.clearcard();
                  customsnackbar("Emart", "Order Placed successfully");
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                bgcolor: redColor,
                textcolor: whiteColor)))
    );
  }
}
