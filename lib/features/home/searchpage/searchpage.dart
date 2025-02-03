import 'package:cached_network_image/cached_network_image.dart';
import 'package:emartecommerce/features/provider_controller/getxsearchbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/consts/colors.dart';
import '../../app/consts/fontstyles.dart';
import '../../categories/item_detail_page.dart';

class Searchpage extends StatelessWidget {
  final List productdata;

  Searchpage({super.key, required this.productdata});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(Getxsearchbar());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: (text) {
            searchController.searchText.value=text;
          },
        ),
      ),
      body: Obx(() {
        final filteredProducts = productdata.where((element) =>
            element["p_name"].toLowerCase().contains(searchController.searchText.trim().toLowerCase())
        ).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: filteredProducts.isNotEmpty
              ? GridView.builder(
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 290,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ItemDetailPage(product: filteredProducts[index]));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: filteredProducts[index]["p_images"][0],
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        filteredProducts[index]["p_name"],
                        style: TextStyle(fontFamily: semibold, color: darkFontGrey),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${filteredProducts[index]["p_price"]}",
                        style: TextStyle(fontFamily: bold, fontSize: 16, color: redColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
              : const Center(child: Text('No products found')),
        );
      }),
    );
  }
}
