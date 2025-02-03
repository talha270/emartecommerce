import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/consts/colors.dart';
import '../../app/consts/strings.dart';

Widget searchwidget({VoidCallback? buttonfunction,required context,required VoidCallback ontap,TextEditingController? controller}){
  return               Card(
    elevation: 10,
    child: TextFormField(
      controller: controller,
      onTap: ontap,
      decoration: InputDecoration(
        filled: true,
        fillColor: whiteColor,
        hintText: searchanything,
        hintStyle:const TextStyle(color: textfieldGrey),
        suffixIcon: IconButton(onPressed: buttonfunction,
            icon: const Icon(Icons.search)),
        border:InputBorder.none,
      ),
    ),
  );
}
