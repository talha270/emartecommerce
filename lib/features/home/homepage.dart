import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/categories/item_detail_page.dart';
import 'package:emartecommerce/features/home/searchpage/searchpage.dart';
import 'package:emartecommerce/features/home/widgets/feature_button.dart';
import 'package:emartecommerce/features/home/widgets/home_button.dart';
import 'package:emartecommerce/features/home/widgets/search_widget.dart';
import 'package:emartecommerce/features/home/widgets/slidershow.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/consts/colors.dart';
import '../app/consts/fontstyles.dart';
import '../app/consts/images.dart';
import '../app/consts/lists.dart';
import '../app/consts/strings.dart';

class Homepage extends StatelessWidget{
  Homepage({super.key});
  var productdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        color: lightGrey,
        padding: const EdgeInsets.all(12),
        child: SafeArea(child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchwidget(context: context, ontap: () {
                // FocusScope.of(context).unfocus();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Searchpage(productdata: productdata,),));
                // FocusScope.of(context).unfocus();
        }),
              const SizedBox(height: 5,),
             Card(child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 2),
               child: SizedBox(width: double.infinity,child: slidershow(list: brandlist, height: 150),),
             )),
             const SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 homebutton(onpressed: () {}, height: MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width/2.5, iconpath: icTodaysDeal, title: todaydeal),
                 homebutton(onpressed: () {}, height: MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width/2.5, iconpath: icFlashDeal, title: flashsale)
               ],
             ),
             const SizedBox(height: 10,),
             Card(child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 2),
               child: SizedBox(width: double.infinity,child: slidershow(list: slider2, height: 150),),
             )),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  homebutton(onpressed: () {}, height: MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width/3.5, iconpath: icTopCategories, title: topcategoreis),
                  homebutton(onpressed: () {}, height: MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width/3.5, iconpath: icBrands, title: brand),
                  homebutton(onpressed: () {}, height: MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width/3.5, iconpath: icTopSeller, title: topsellers),
                ],
              ),
              const SizedBox(height: 20,),
              const Text(featuredcategories,style: TextStyle(color: darkFontGrey,fontSize: 18,fontFamily: semibold),),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                  Row(
                    children: List.generate(featureimages1.length, (index) => featurebutton(context: context,imagepath:featureimages1[index], title: featuretitle1[index]),),
                  ) ,
                    SizedBox(height: 10,),
                    Row(
                      children: List.generate(featureimages2.length, (index) => featurebutton(context:context,imagepath:featureimages2[index], title: featuretitle2[index]),),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(color: redColor,
                image: DecorationImage(image: AssetImage(featured_img),fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(featureproduct,style: TextStyle(color: whiteColor,fontFamily: bold,fontSize: 18),),
                    const SizedBox(height: 10,),
                    StreamBuilder(
                      stream: FirebaseServices.getfeaturedproduct(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Text("no featured products");
                        } else {
                          var data = snapshot.data!.docs;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                data.length,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ItemDetailPage(
                                            product: data[index],
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: data[index]["p_images"][0],
                                          height: 170,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data[index]["p_name"],
                                          style: TextStyle(
                                              fontFamily: semibold,
                                              color: darkFontGrey),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${data[index]["p_price"]}".numCurrency,
                                          style: TextStyle(
                                              fontFamily: bold,
                                              fontSize: 16,
                                              color: redColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
          Card(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: SizedBox(width: double.infinity,child: slidershow(list: slider2, height: 150),),
          )),
              const SizedBox(height: 20,),
              Text("All Products",style: TextStyle(fontSize: 18,fontFamily: bold,color: darkFontGrey ),),
              const SizedBox(height: 20,),
              StreamBuilder(stream: FirebaseServices.getallproduct(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),);
                }
                else if(snapshot.data!.docs.isEmpty){
                  return Center(
                    child: Text("no any product"),
                  );
                } else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }else{
                  productdata=snapshot.data!.docs;
                 return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productdata.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 280,crossAxisSpacing: 8,mainAxisSpacing: 8), itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailPage(product: productdata[index],),));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(imageUrl: productdata[index]["p_images"][0],width: 200,height: 200,fit: BoxFit.fill,),
                            const SizedBox(height: 10,),
                            Text(productdata[index]["p_name"],style: TextStyle(fontFamily: semibold,color: darkFontGrey),),
                            const SizedBox(height: 10,),
                            Text("${productdata[index]["p_price"]}".numCurrency,style: TextStyle(fontFamily: bold,fontSize: 16,color: redColor),),
                          ],
                        ),
                      ),
                    );
                  },);
                }
              },)
            ],
          ),
        )),
      )
    );
  }
}
