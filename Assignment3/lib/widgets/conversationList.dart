import 'dart:io';

import 'package:chatapp/createChatUser.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/user.dart';
import 'package:flutter/material.dart';

import '../ChatDetailPage.dart';

class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String image;
  String time;
  bool isMessageRead;
  User user;
  ConversationList({Key? key, required this.name,required this.messageText,
  required this.image,required this.time,required this.isMessageRead
  ,required this.user}) : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState(user: this.user);
}

class _ConversationListState extends State<ConversationList> {
  late User user;
  _ConversationListState({required this.user});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() async {
        createChatUser().getmsgstemp(user);
        await Future.delayed(const Duration(seconds: 1));
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage(user: user,);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: const TextStyle(fontSize: 16),),
                          const SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}