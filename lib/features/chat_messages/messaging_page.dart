import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/provider_controller/getxchatcontroller.dart';
import 'package:emartecommerce/features/provider_controller/getxproductcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:emartecommerce/features/chat_messages/chat_page.dart';
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/app/consts/images.dart';
import 'package:emartecommerce/features/service/firebase_services/firebase_services.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

  // Fetch unseen messages count
  getUnseenMessageCount(String chatDocId, String currentUserId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId)
        .collection('messages')
        .where('uid', isNotEqualTo: currentUserId)
        .snapshots();
  }

  // Calculate the number of unseen messages
  int countUnseen(List<QueryDocumentSnapshot> messages) {
    int count = 0;
    for (var message in messages) {
      if (!message['seen']) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "My Messages",
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseServices.getallusermessages(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Messages yet",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String chatDocId = data[index].id;

                return StreamBuilder(
                  stream: getUnseenMessageCount(chatDocId, currentUserId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> unseenSnapshot) {
                    if (!unseenSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator()); // Loading state
                    }
                    int unseenCount = countUnseen(unseenSnapshot.data!.docs);

                    return Card(
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          final con=Get.put(Getxchatcontroller());
                          con.setFriendNameAndId(
                            name: data[index]["friend_name"],
                            id: data[index]["to_id"],
                          );
                          Get.to(ChatPage());
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: redColor,
                          child: Image.asset(profile_defauld, fit: BoxFit.contain),
                        ),
                        title: Text(
                          data[index]["friend_name"],
                          style: TextStyle(fontFamily: semibold, fontSize: 17),
                        ),
                        subtitle: Text(
                          data[index]["last_message"],
                          style: TextStyle(color: Colors.grey.shade500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              intl.DateFormat().add_yMd().format(
                                data[index]["created_on"].toDate(),
                              ),
                            ),
                            if (unseenCount > 0)  // Display unseen count if > 0
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "$unseenCount",
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
