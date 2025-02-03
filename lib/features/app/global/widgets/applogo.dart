
import 'package:flutter/material.dart';

import '../../consts/images.dart';

applogowidget({required double height,required double width}){
  return Container(
    height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(icAppLogo));
}
