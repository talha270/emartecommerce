import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_textfeild.dart';
import 'package:emartecommerce/features/app/global/widgets/custombutton.dart';
import 'package:emartecommerce/features/app/global/widgets/validations_for_textfield.dart';
import 'package:emartecommerce/features/card/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetail extends StatelessWidget {
  ShippingDetail({super.key});
  final addresscontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final postalcodecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            "Shipping Info",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    customtextfeild(
                        validatortest: (value) {
                          return passwordvalidate(value);
                        },
                        hint: "Address",
                        obscure: false,
                        title: "Address",
                        controller: addresscontroller),
                    customtextfeild(
                        validatortest:  (value) {
                         return passwordvalidate(value);
                        },
                        hint: "City",
                        obscure: false,
                        title: "City",
                        controller: citycontroller),
                    customtextfeild(
                        validatortest: (value) {
                         return passwordvalidate(value);
                        },
                        hint: "State",
                        obscure: false,
                        title: "State",
                        controller: statecontroller),
                    customtextfeild(
                        validatortest: (value) {
                          return passwordvalidate(value);
                        },
                        hint: "Postal Code",
                        obscure: false,
                        title: "Postal Code",
                        controller: postalcodecontroller),
                    customtextfeild(
                        validatortest: (value) {
                          return passwordvalidate(value);
                        },
                        hint: "Phone",
                        obscure: false,
                        title: "Phone",
                        controller: phonecontroller),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: 50,
            child: customButton(
                title: "Continue",
                callback: () {
                  final isvalid=_formkey.currentState!.validate();
                  if(isvalid){
                    Get.to(PaymentMethod(address: addresscontroller.text,city: citycontroller.text,phone: phonecontroller.text,postalcode: postalcodecontroller.text,state: statecontroller.text));
                  }
                },
                bgcolor: redColor,
                textcolor: whiteColor)));
  }
}
