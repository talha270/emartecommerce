import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/consts/colors.dart';
import '../app/consts/fontstyles.dart';
import '../app/consts/lists.dart';
import '../app/consts/strings.dart';
import '../auth_pages/widgets/bg_widget.dart';
import 'categories_details.dart';

class CategoriesPage extends StatelessWidget{
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return bgwidget(hight:MediaQuery.sizeOf(context).height,child: Scaffold(
      appBar: AppBar(
        title: const Text(categories,style: TextStyle(fontFamily: bold,color: whiteColor),),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.put(Getxproductcontroller()).getsubcategories(categoriesitemsmap[index]["name"].toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesDetails(title: categoriesitemsmap[index]["name"].toString()),));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(blurRadius: 3)
                  ]
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:  BorderRadius.circular(12),
                        child: Image.asset(categoriesimage[index],height: 120,width: 200,fit: BoxFit.cover,)),
                    const SizedBox(height: 10,),
                    Align(
                        alignment: Alignment.center,
                        child: Text(categoriesitemsmap[index]["name"].toString(),maxLines: 1,style: const TextStyle(color: darkFontGrey,overflow: TextOverflow.ellipsis),))
                  ],
                ),),
              );
            },),
      ),
    ));
  }
}
