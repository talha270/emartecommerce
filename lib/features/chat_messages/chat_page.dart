import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/fontstyles.dart';
import 'package:emartecommerce/features/chat_messages/widgets/senderbubble.dart';
import 'package:emartecommerce/features/provider_controller/getxchatcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ChatPage extends StatelessWidget {
 ChatPage({super.key});
  final controller = Get.put(Getxchatcontroller());

  bool isloading = false;

  ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 5,
          title: Text(
            // "${widget.friendname}",
            "wefdv ",style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ),
        body: FutureBuilder(
              future: controller.getChatId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for chatDocId
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle errors in chatDocId initialization
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: StreamBuilder(
                          stream: controller
                              .getAllMessages(), // This now directly provides the stream
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text("Send a message....",
                                    style: TextStyle(color: darkFontGrey)),
                              );
                            } else {
                              // Add a post-frame callback to scroll after data builds
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollToBottom();
                              });
                              return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.docs[index];
                                    bool isSender = data["uid"] ==
                                        FirebaseAuth.instance.currentUser!.uid;
                                    return Align(
                                        alignment: isSender
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: messageBubble(
                                          isSeen: data['seen'],
                                          isSender: isSender,
                                          context: context,
                                          message: data["message"],
                                          time: intl.DateFormat("h:mma").format(
                                              data["created_on"] == null
                                                  ? DateTime.now()
                                                  : data["created_on"].toDate()),
                                        ),
                                      );
                                  },
                                );
                            }
                          },
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 8),
                          height: 70,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: controller.messageController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: textfieldGrey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: textfieldGrey)),
                                    hintText: "Type a message..."),
                              )),
                              IconButton(
                                  onPressed: () {
                                    controller.sendMessage(
                                        message:
                                            controller.messageController.text);
                                    controller.messageController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: redColor,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            )
        );
  }
}
