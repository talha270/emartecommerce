import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/consts/firebase_const.dart';
import 'getxhomecontroller.dart';

class Getxchatcontroller extends GetxController{

  var chats = firestore.collection(chatscollection);

  String friendName = "";
  String friendId = "";
  var senderName = Getxhomecontroller.username.value;

  String? chatDocId;
  var isLoading = true.obs;
  final messageController = TextEditingController();

  void setFriendNameAndId({required String name, required String id}) {
    friendName = name;
    friendId = id;
    print("Sender: ${FirebaseAuth.instance.currentUser!.uid}");
    print("Friend: $friendId");
  }


  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllMessages() {
    if (chatDocId != null && chatDocId!.isNotEmpty) {
      return firestore
          .collection(chatscollection)
          .doc(chatDocId)
          .collection(messagesCollection)
          .orderBy("created_on", descending: false)
          .snapshots()
          .map((snapshot) {
        // Mark messages as seen when the recipient views them
        snapshot.docs.forEach((doc) {
          if (doc['uid'] != FirebaseAuth.instance.currentUser!.uid && !doc['seen']) {
            doc.reference.update({"seen": true});
          }
        });
        return snapshot;
      });
    }
    return null;
  }



  getChatId() async {

    final result = await chats.where("users", isEqualTo: {
      friendId: null,
      FirebaseAuth.instance.currentUser!.uid: null,
    }).limit(1).get();

    if (result.docs.isNotEmpty) {
      return chatDocId = result.docs.single.id;
    } else {
      final newChatDoc = await chats.add({
        "created_on": FieldValue.serverTimestamp(),
        "last_message": "",
        "users": {friendId: null, FirebaseAuth.instance.currentUser!.uid: null},
        "to_id": friendId,
        "from_id": FirebaseAuth.instance.currentUser!.uid,
        "friend_name": friendName,
        "sender_name": senderName
      });
      print("New chat ID created: $chatDocId");
      return chatDocId = newChatDoc.id;
    }
  }

  Future<void> sendMessage({required String message}) async {
    if (message.trim().isEmpty || chatDocId == null) return;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    await chats.doc(chatDocId).update({
      "created_on": FieldValue.serverTimestamp(),
      "last_message": message,
      "to_id": friendId,
      "from_id": userId,
    });

    await chats.doc(chatDocId).collection(messagesCollection).add({
      "created_on": FieldValue.serverTimestamp(),
      "message": message,
      "uid": userId,
      "seen": false,
    });

    messageController.clear();
  }
}
