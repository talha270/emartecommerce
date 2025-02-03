import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future exitdailog({required context}){
  return showDialog(
    barrierDismissible: false,
    context: context, builder: (context) {
    return AlertDialog(
      scrollable: true,
      elevation: 20,
      shadowColor: Colors.black,
      title: Text("Confirm"),
      content:  Column(
        children: [
          // const Divider(),
          const SizedBox(height: 10,),
          const Text("Are you sure you want to exit?",style: TextStyle(fontSize: 16,color: darkFontGrey),),
        ],
      ),
      actions: [
       TextButton(onPressed: () {
         SystemNavigator.pop();
       }, child: Text("Yes")),
       TextButton(onPressed: () {
         Navigator.pop(context);
       }, child: Text("No")),
      ],
    );
  },);


  // Dialog(
  //   child: Card(
  //     child:
  //   ),
  //
  // );
}
