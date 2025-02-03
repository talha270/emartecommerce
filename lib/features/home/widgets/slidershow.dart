import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

slidershow({required List list, required double height}) {
  return CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(),
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                list[index],
                fit: BoxFit.fill,
              )),
        );
      },
      options: CarouselOptions(
          autoPlay: true,
          height: height,
          aspectRatio: 16 / 9,
          viewportFraction: 0.99,
          autoPlayCurve: Curves.fastOutSlowIn,
          // autoPlayAnimationDuration: const Duration(seconds: 2),
          // enlargeCenterPage: false,
          pageSnapping: true));
}
