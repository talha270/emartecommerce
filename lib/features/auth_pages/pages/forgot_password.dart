import 'package:emartecommerce/features/app/global/widgets/validations_for_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../app/consts/strings.dart';
import '../../app/global/widgets/applogo.dart';
import '../../app/global/widgets/custom_textfeild.dart';
import '../../app/global/widgets/custombutton.dart';
import '../widgets/bg_widget.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgwidget(hight: MediaQuery.sizeOf(context).height,
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
                "Forgot Password",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: customButton(
                            title: "Send",
                            callback: () async{
                              final isvalid=_formkey.currentState!.validate();
                              if(isvalid){
                                try{
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);

                                  showalertbox(context: context,text: "Check your email for forgot the password.");
                                }on FirebaseAuthException catch(ex){
                                  showalertbox(context: context,text: ex.toString());
                                }
                              }
                            },
                            bgcolor: redColor,
                            textcolor: whiteColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }

  showalertbox({required BuildContext context,required String text}) {

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(

          elevation: 20,
          // backgroundColor: Colors.red.shade200,
          // icon: Icon(Icons.ac_unit_sharp),
          title: const Text("Emart",style: TextStyle(fontFamily: bold,color: redColor),),
          shadowColor: Colors.black,
          scrollable: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Ok")),
          ],
        );
      },
    );
  }
}
