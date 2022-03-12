import 'package:chatapp/user.dart';
import 'package:flutter/cupertino.dart';

class ChatUsers{
  String name;
  String messageText;
  String image;
  String time;
  User user;
  ChatUsers({required this.name,required this.messageText,
  required this.image,required this.time,required this.user});
}