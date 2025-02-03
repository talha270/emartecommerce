import 'package:emartecommerce/features/app/consts/firebase_const.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_snackbar.dart';
import 'package:emartecommerce/features/app/global/widgets/validations_for_textfield.dart';
import 'package:emartecommerce/features/home/home.dart';
import 'package:emartecommerce/features/provider_controller/getxauthcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../app/consts/strings.dart';
import '../../app/global/widgets/applogo.dart';
import '../../app/global/widgets/custom_textfeild.dart';
import '../../app/global/widgets/custombutton.dart';
import '../widgets/bg_widget.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController retypepasswordcontroller =
      TextEditingController();

  final controller = Get.put(Getxauthcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgwidget(
            hight: MediaQuery.sizeOf(context).height,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  applogowidget(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      width: MediaQuery.sizeOf(context).height * 0.1),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Join the $appname",
                    style: TextStyle(
                        fontFamily: bold, fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(blurRadius: 5)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 13),
                    child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Container(height: 567,)
                            customtextfeild(
                                validatortest: (value) {
                                  return namevalidator(value);
                                },
                                hint: namehint,
                                obscure: false,
                                title: name,
                                controller: namecontroller),
                            customtextfeild(
                                validatortest: (value) {
                                 return emailvalidate(value);
                                },
                                hint: emailhint,
                                obscure: false,
                                title: email,
                                controller: emailcontroller),
                            customtextfeild(
                                validatortest: (value) {
                                 return createpasswordvaliator(value);
                                },
                                hint: passwordhind,
                                obscure: true,
                                title: password,
                                controller: passwordcontroller),
                            customtextfeild(
                                validatortest: (value) {
                                  return matchpassword(value, passwordcontroller);
                                },
                                hint: passwordhind,
                                obscure: true,
                                title: retypepassword,
                                controller: retypepasswordcontroller),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Obx(
                                ()=> Checkbox(
                                    checkColor: redColor,
                                    value: controller.ischeck.value,
                                    onChanged: (value) {
                                      controller.ischeck.value = value!;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(
                                            fontFamily: regular,
                                            color: fontGrey)),
                                    TextSpan(
                                        text: termandcondition,
                                        style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor)),
                                    TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor)),
                                    TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor)),
                                  ])),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => controller
                                      .isloadingsignup.value
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width - 50,
                                      child: customButton(
                                          title: signup,
                                          callback: () {
                                            if (controller.ischeck.value) {
                                              final isvalid = _formkey
                                                  .currentState!
                                                  .validate();
                                              if (isvalid) {
                                                controller.isloadingsignup.value=true;
                                                try {
                                                  controller
                                                      .signupmethod(
                                                          email: emailcontroller
                                                              .text,
                                                          password:
                                                              passwordcontroller
                                                                  .text,
                                                          context: context)
                                                      .then(
                                                        (value) => controller
                                                            .storeuserdata(
                                                                name:
                                                                    namecontroller
                                                                        .text,
                                                                email:
                                                                    emailcontroller
                                                                        .text,
                                                                password:
                                                                    passwordcontroller
                                                                        .text),
                                                      )
                                                      .then(
                                                    (value) {
                                                      customsnackbar(loggedinsuccessfully, "Enjoy your shopping");
                                                      controller.isloadingsignup
                                                          .value = false;
                                                     Get.offAll(Home());
                                                    },
                                                  );
                                                } catch (e) {
                                                  controller.isloadingsignup.value=false;
                                                  auth.signOut();
                                                  customsnackbar("Error", e.toString());
                                                }
                                              }
                                            }
                                          },
                                          bgcolor:
                                              controller.ischeck.value ? redColor : lightGrey,
                                          textcolor: Colors.white)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(alreadyhaveanaccount,
                                    style: TextStyle(
                                        fontFamily: bold, color: fontGrey)),
                                const SizedBox(
                                  width: 3,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.isloadingsignup.value = false;
                                    Get.back();
                                  },
                                  child: const Text(login,
                                      style: TextStyle(
                                          fontFamily: bold, color: redColor)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )));
  }
}
