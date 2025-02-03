import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:flutter/material.dart';

Widget orderStatus({required Icon firsticon,required String title,required Color color}){
  return Row(
    children: [
    Container(
          decoration: BoxDecoration(
            border: Border.all(color: color,width: 2),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child:firsticon
          )),
      SizedBox(width: 20,),
      Expanded(
        child: Container(
          color: Colors.grey.shade300,
          height: 2,
        ),
      ),
      SizedBox(width: 40,),
      Text(title,style: TextStyle(color: Colors.grey.shade400),),
      SizedBox(width: 10,),
    ],
  );
}
