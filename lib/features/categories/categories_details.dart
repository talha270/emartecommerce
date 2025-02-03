import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../app/consts/colors.dart';
import '../app/consts/fontstyles.dart';
import '../auth_pages/widgets/bg_widget.dart';
import 'item_detail_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';

class CategoriesDetails extends StatelessWidget {
  final String title;
  final controller = Get.put(Getxproductcontroller());

  CategoriesDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgwidget(
      hight: MediaQuery.sizeOf(context).height,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: whiteColor),
          ),
          title: Text(
            title,
            style: const TextStyle(fontFamily: bold, color: whiteColor),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseServices.getproducts(categories: title),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No products available"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              // Assign the fetched data to the controller
              controller.updateProducts(snapshot.data!.docs);

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bubble Filter Section
                    Obx(
                          () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            controller.subcategories.length + 1, // +1 for "All"
                                (index) {
                              String bubbleText = index == 0 ? "All" : controller.subcategories[index - 1];
                              bool isSelected = controller.selectedFilter.value == bubbleText;
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedFilter.value = bubbleText;
                                  controller.filterProducts(); // Apply the filter
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: isSelected ? redColor : whiteColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      bubbleText,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: semibold,
                                        color: isSelected ? whiteColor : darkFontGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Product Grid Section
                    Obx(
                          () => Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.filteredProducts.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            var product = controller.filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                controller.checkisfav(product);
                                Get.to(ItemDetailPage(product: product));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: const [BoxShadow(blurRadius: 4)],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: product["p_images"][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      product["p_name"],
                                      style: TextStyle(
                                        fontFamily: semibold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${product["p_price"]}".numCurrency,
                                      style: TextStyle(
                                        fontFamily: bold,
                                        fontSize: 16,
                                        color: redColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
