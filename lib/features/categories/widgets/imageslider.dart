import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

imageslider(product){
  return CarouselSlider.builder(
      itemCount: product["p_images"].length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(),
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product["p_images"][index],
                fit: BoxFit.fill,
              )),
        );
      },
      options: CarouselOptions(
          autoPlay: true,
          height: Get.height * 0.5,
          aspectRatio: 16 / 9,
          // viewportFraction: 0.9,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration:
          const Duration(seconds: 2),
          enlargeCenterPage: true,
          pageSnapping: true));
}
