import 'package:emartecommerce/features/provider_controller/getxsplashcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';
import '../consts/fontstyles.dart';
import '../consts/images.dart';
import '../consts/strings.dart';
import '../global/widgets/applogo.dart';

class Splashpage extends StatelessWidget{

  Splashpage({super.key});
  final controller=Get.put(Getxsplashcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height*0.4,
                child: Align(alignment:Alignment.topLeft,child: Image.asset(icSplashBg,color: Colors.white,width: 300,))),
            const SizedBox(height: 20,),
            applogowidget(width: MediaQuery.sizeOf(context).height*0.1,height: MediaQuery.sizeOf(context).height*0.1),
            const SizedBox(height: 10,),
            const Text(appname,style: TextStyle(fontFamily: bold,fontSize: 22,color: Colors.white),),
            const Text(appversion,style: TextStyle(color: Colors.white),),
            const Spacer(),
            const Text(credits,style: TextStyle(fontFamily: semibold,color: Colors.white),),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
