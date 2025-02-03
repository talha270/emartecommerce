import 'package:flutter/material.dart';

import '../../app/consts/images.dart';

Widget bgwidget({Widget? child,required hight}){
  return Container(
    height: hight,
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill),
    ),
    child: child,
  );
}
