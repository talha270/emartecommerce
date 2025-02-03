import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/profile/widgets/count_row.dart';
import 'package:emartecommerce/features/profile/widgets/editbutton.dart';
import 'package:emartecommerce/features/profile/widgets/listcolumns.dart';
import 'package:emartecommerce/features/profile/widgets/profile_row.dart';
import 'package:emartecommerce/features/provider_controller/getxhomecontroller.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/consts/colors.dart';
import '../auth_pages/widgets/bg_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
   final controller=Get.put(Getxhomecontroller());
    return Scaffold(
        body: bgwidget(hight: MediaQuery.sizeOf(context).height,child: FutureBuilder(
          future: FirebaseServices.getcount(),
          builder: (context,AsyncSnapshot countsnapshot) {
            if(!countsnapshot.hasData){
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),);
            }else{
              var countdata=countsnapshot.data;
              return StreamBuilder(
                stream: FirebaseServices.getuserdata(uid: FirebaseAuth.instance.currentUser!.uid),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  }else if(snapshot.data!.docs.isEmpty){
                    return Center(
                      child: Text("no data"),
                    );
                  } else if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else {
                    var data=snapshot.data!.docs[0];

                    return SafeArea(
                        child: Column(
                          children: [
                            editbutton(data),
                            profilerow(data, controller),
                            const SizedBox(
                              height: 20,
                            ),
                            countrow(countdata),
                            const SizedBox(
                              height: 20,
                            ),
                            listcolumn()
                          ],
                        ));
                  }
                },
              );
            }
          },
        ))
    );
  }
}
