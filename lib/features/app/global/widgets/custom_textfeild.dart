
import 'package:flutter/material.dart';

import '../../consts/colors.dart';
import '../../consts/fontstyles.dart';


Widget customtextfeild({required String? Function(String?) validatortest,required String hint,required bool obscure,required String title,required TextEditingController controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Text(title,style: const TextStyle(color: redColor,fontFamily: semibold,fontSize: 16),),
      const SizedBox(height: 5,),
      TextFormField(
        validator: validatortest,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontFamily: semibold,color: textfieldGrey),
        hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          ),

        ),
      ),
      const SizedBox(height: 5,),
    ],
  );
}
