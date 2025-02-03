import 'package:emartecommerce/features/provider_controller/getxhomecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'features/app/consts/colors.dart';
import 'features/app/consts/fontstyles.dart';
import 'features/app/splash/splashpage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => Getxhomecontroller(),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eMart',
      theme: ThemeData(
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          fontFamily: regular
      ),
      home: Splashpage(),
    );
  }
}
