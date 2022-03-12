
import 'package:chatapp/ChatMessage.dart';
import 'package:chatapp/models/chatUsersModel.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/database_service.dart';
import 'package:chatapp/user.dart' as a;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// ignore: camel_case_types
class createChatUser{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String currentuserid;
  late final String currentusername;
 // final StreamController<List<message>> _msgsController =
  //    StreamController<List<message>>();
  static List<message> tempmsgs= <message>[];

  List<ChatUsers> getalist() {
    currentuserid = _auth.currentUser!.uid;
    List<a.User> users = DatabaseService.userlist;
    List<ChatUsers> chatUsers = <ChatUsers>[];

    for (var user in users) {
      if (!currentuserid.contains(user.id)){
      //print("print user id: " +user.id);
      ChatUsers cu = ChatUsers(name: user.displayName, 
      messageText: "Awesome Setup", image: "assets/images/default.png", 
      time: "Now", user: user);
      chatUsers.add(cu);
      }

      
  
    }

  return chatUsers;

  }

  String getchatid(a.User user){
    currentusername = _auth.currentUser!.displayName.toString();
    //currentuserid = _auth.currentUser!.uid;
    String chatid ="";
    if(currentusername.compareTo(user.displayName)>0){
      chatid = currentusername + "_" + user.displayName;
    } else {
      chatid = user.displayName + "_" + currentusername;
    }


    return chatid;
  }

  List<ChatMessage> getchatmessages(List<message> msgs){
    currentusername = _auth.currentUser!.displayName.toString();
    List<ChatMessage> chatmsgs = <ChatMessage>[];

    for (var item in tempmsgs) {
      if(currentusername.contains(item.postby)){
      ChatMessage cm = ChatMessage(messageContent: item.messageText, messageType: "sender");
      chatmsgs.add(cm);
      } else {
      ChatMessage cm = ChatMessage(messageContent: item.messageText, messageType: "receiver");
      chatmsgs.add(cm);
      }
    }
   
    return chatmsgs;

  }

 Future<void> getmsgstemp(a.User user) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    tempmsgs.clear();
    String chatid = getchatid(user);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(chatid).get();
    for (var element in querySnapshot.docs) {
      message msg = message.fromMap(element.id, element.data());
      //msgs.add(msg);
      tempmsgs.add(msg);
    }
    tempmsgs.sort((a, b) => a.postdate.compareTo(b.postdate));
  }

  List<message> getmsgslist(){
    return tempmsgs;
  }

  String getcurrentuserid(){
    return _auth.currentUser!.uid;
  }

  a.User? getcurrentuser(){
    return DatabaseService.userMap[_auth.currentUser!.uid];
  }

}