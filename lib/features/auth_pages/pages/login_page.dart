import 'package:emartecommerce/features/app/global/widgets/custom_snackbar.dart';
import 'package:emartecommerce/features/app/global/widgets/validations_for_textfield.dart';
import 'package:emartecommerce/features/auth_pages/pages/forgot_password.dart';
import 'package:emartecommerce/features/auth_pages/pages/signup_page.dart';
import 'package:emartecommerce/features/provider_controller/getxauthcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../app/consts/lists.dart';
import '../../app/consts/strings.dart';
import '../../app/global/widgets/applogo.dart';
import '../../app/global/widgets/custom_textfeild.dart';
import '../../app/global/widgets/custombutton.dart';
import '../../home/home.dart';
import '../widgets/bg_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Getxauthcontroller());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgwidget(
            hight: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
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
                    "Log in to $appname",
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
                    child: Column(
                      children: [
                        // Container(height: 790,),
                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
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
                                      return passwordvalidate(value);
                                    },
                                    hint: passwordhind,
                                    obscure: true,
                                    title: password,
                                    controller: passwordcontroller),
                              ],
                            )),
                        Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassword(),
                                      ));
                                },
                                child: const Text(forgotpassword))),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => controller
                                  .isloadinglogin.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              : SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 50,
                                  child: customButton(
                                      title: login,
                                      callback: () {
                                        final isvalid =
                                            _formkey.currentState!.validate();
                                        if (isvalid) {
                                          controller.isloadinglogin.value=true;
                                          controller
                                              .loginmethod(
                                                  email: emailcontroller.text,
                                                  password:
                                                      passwordcontroller.text,
                                                  context: context)
                                              .then(
                                            (value) {
                                              if (value != null) {
                                                controller.isloadinglogin
                                                    .value = false;
                                                Get.offAll(Home());
                                                customsnackbar("Login", "Enjoy your shopping");
                                              } else {
                                                controller.isloadinglogin.value=false;
                                              }
                                            },
                                          );
                                        }
                                      },
                                      bgcolor: redColor,
                                      textcolor: Colors.white)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          createnewaccount,
                          style: TextStyle(color: fontGrey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width - 50,
                            child: customButton(
                                title: signup,
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      ));
                                },
                                bgcolor: lightgolden,
                                textcolor: redColor)),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          loginwith,
                          style: TextStyle(color: fontGrey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconlist[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(height: 600,),
                ],
              ),
            )));
  }
}
