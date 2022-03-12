import 'package:chatapp/ChatMessage.dart';
import 'package:chatapp/Profile.dart';
import 'package:chatapp/createChatUser.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/user.dart' as a;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as b;

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key, required this.user}) : super(key: key);
  final a.User user;
  

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(user: this.user);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late a.User user;
  _ChatDetailPageState({required this.user});
  
    List<ChatMessage> messages = createChatUser().getchatmessages(createChatUser().getmsgslist());
  
  
  // List<ChatMessage> messages = [
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Hey Kriss, I am doing fine dude. wbu?",
  //       messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Is there any thing wrong?", messageType: "sender"),
  // ];

  final _newmsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Text(user.firstname + " " + user.lastname,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
      icon: const Icon(
        Icons.info,
        color: Colors.grey,
      ),
      tooltip: 'info',
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => showProfile(user: user,)));

      },
    ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                   Expanded(
                    child: TextField(controller: _newmsg,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
         if (_newmsg.text.isNotEmpty){
              addmessage(_newmsg.text, user);
          }
          createChatUser().getmsgstemp(user);
        await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => ChatDetailPage(user: user,))));
          },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addmessage(String message, a.User user) async{
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final b.FirebaseAuth _auth = b.FirebaseAuth.instance;  
    var now = DateTime.now();
    String time = DateFormat('MM-dd-yyyy, kk:mm').format(now);
    String currentusername = _auth.currentUser!.displayName.toString();
    await _db.collection(createChatUser().getchatid(user)).add(
          {  
            "message" : message,
            "postby" : currentusername,
            "postdate": time
          });
  }
  

  
}
