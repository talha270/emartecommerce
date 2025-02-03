import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
// User? currentuser=auth.currentUser;
const String userscollection="users";

const String productscollection="products";

const String cartcollection="card";

const String chatscollection="chats";
const String messagesCollection="messages";
