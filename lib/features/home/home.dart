import 'package:emartecommerce/features/app/global/widgets/exit_dailog.dart';
import 'package:emartecommerce/features/provider_controller/getxhomecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/consts/colors.dart';
import '../app/consts/fontstyles.dart';
import '../app/consts/images.dart';
import '../app/consts/strings.dart';
import '../card/card_pages.dart';
import '../categories/categories_page.dart';
import '../profile/profile_page.dart';
import 'homepage.dart';

class Home extends StatelessWidget{
  Home({super.key});

    final con=Get.find<Getxhomecontroller>();

  @override
  Widget build(BuildContext context) {
    // final pagecontroller=Provider.of<Homecontroller>(context);
    return PopScope(
        canPop: false,
       onPopInvoked: (didPop) {
         print("pop scope is works: $didPop");
         exitdailog(context: context);
       },
      child: Scaffold(
        body:PageView(
              controller: con.pagecontroller,
              onPageChanged: (newvalue) => con.changeindex(index1:newvalue),
              children: [
                Homepage(),
                const CategoriesPage(),
                CardPages(),
                const ProfilePage()
              ],
            ),
        bottomNavigationBar: GetBuilder<Getxhomecontroller>(
          builder: (controller) => BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
          BottomNavigationBarItem(icon: Image.asset(icCategories ,width: 26,),label: categories),
          BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
          BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account),
        ],
          currentIndex: con.index,
          onTap: (value) => con.changeindex(index1: value),
          backgroundColor: whiteColor,
          type:BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
        ),)
      ),
    );
  }
}
