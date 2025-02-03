
import 'package:flutter/material.dart';

import '../../consts/fontstyles.dart';

customButton({required String title,required VoidCallback callback,required Color bgcolor,required Color textcolor}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      onPressed: () {
  callback();
  }, child: Text(title,style: TextStyle(fontFamily: bold,color: textcolor),));
}
