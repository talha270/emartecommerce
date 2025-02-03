import 'package:intl/intl.dart'as intl;
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/myorders/widgets/order_place_details.dart';
import 'package:emartecommerce/features/myorders/widgets/order_status.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text(
          "Order Details",
          style: TextStyle(fontFamily:semibold,color: redColor),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Card(
               elevation: 10,
               child: Container(
                 margin: EdgeInsets.all(10),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Expanded(
                           child: Column(
                             children: [
                               SizedBox(
                                 height: 50,
                                 child: orderStatus(
                                   title: "Confirmed",
                                   firsticon: Icon(
                                     Icons.thumb_up_alt_rounded,
                                     size: 22,
                                     color: Colors.blueAccent,
                                   ),
                                   color: Colors.blueAccent,
                                 ),
                               ),
                               SizedBox(
                                 height: 50,
                                 child: orderStatus(
                                   title: "OnDelivery",
                                   firsticon: Icon(
                                     Icons.delivery_dining_rounded,
                                     size: 22,
                                     color: Colors.orange,
                                   ),
                                   color: Colors.orange,
                                 ),
                               ),
                               SizedBox(
                                 height: 50,
                                 child: orderStatus(
                                   title: "Delivered",
                                   firsticon: Icon(
                                     Icons.done_all_outlined,
                                     size: 22,
                                     color: Colors.purple,
                                   ),
                                   color: Colors.purple,
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space items evenly
                           children: [
                             Container(
                               width: 4,
                               height: 20,
                               decoration: BoxDecoration(
                                   color: redColor,
                                   borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5))
                               ),
                             ),
                             CircleAvatar(
                               radius: 10,
                               backgroundColor: data["order_confirmed"]?redColor
                                   :Colors.grey.shade500,
                             ),
                             Container(
                               width: 2,
                               height: 30,
                               color:data["order_on_delivery"]?redColor:Colors.grey.shade400,
                             ),
                             CircleAvatar(
                               radius: 10,
                               backgroundColor: data["order_on_delivery"]?redColor:Colors.grey.shade500,
                             ),
                             Container(
                               width: 2,
                               height: 30,
                               color: data["order_delivered"]?redColor:Colors.grey.shade400,
                             ),
                             CircleAvatar(
                               radius: 10,
                               backgroundColor: data["order_delivered"]?redColor:Colors.grey.shade500,
                             ),
                             Container(
                               width: 2,
                               height: 17,
                               // color: Colors.red,
                             ),
                           ],
                         ),
                       ],
                     ),
                     Divider(),
                     SizedBox(height: 10,),
                     orderplacedetail(d1: data["order_code"],d2: data["shipping_method"],title1: "Order Code",title2: "Shipping Method"),
                     orderplacedetail(d1:intl.DateFormat().add_yMd().format( data["order_date"].toDate()),d2: data["payment_method"],title1: "Order Date",title2: "Payment Method"),
                     orderplacedetail(d1:"Unpaid",d2: "Order Placed",title1: "Payment Status",title2: "Delivery Status"),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Shipping Address",style: TextStyle(fontFamily: semibold),),
                             Text(data["order_by_name"]),
                             Text(data["order_by_email"]),
                             Text(data["order_by_address"]),
                             Text(data["order_by_city"]),
                             Text(data["order_by_state"]),
                             Text(data["order_by_phone"]),
                             Text(data["order_by_postalcode"]),
          
                           ],
                         ),
                         SizedBox(
                           width: 120,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Total Amount",style: TextStyle(fontFamily: semibold),),
                               Text("${data["total_amount"]}".numCurrency,style: TextStyle(color: redColor,fontFamily: bold),)
                             ],
                           ),
                         )
                       ],
                     ),
                   ],
                 ),
               ),
             ),
              Divider(),
              // SizedBox(height: 10,),
             Card(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Text("Ordered Product",style: TextStyle(fontSize: 16,color: darkFontGrey,fontFamily: semibold),),
                     SizedBox(height: 10,),
                     ListView(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       children: List.generate(data["orders"].length, (index) {
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             orderplacedetail(title1: data["orders"][index]["title"], title2: "${data["orders"][index]["total_price"]}".numCurrency, d1:" ${data["orders"][index]["quantity"]}x", d2: "Refundable"),
                             Container(
                               height: 2,
                               width: 30,
                               color: Color(data["orders"][index]["color"]),
                             ),
                             const SizedBox(height: 5,),
                           ],
                         );
                       },),
                     )
                   ],
                 ),
               ),
             ),

            ],
          ),
        ),
      ),
    );
  }
}
