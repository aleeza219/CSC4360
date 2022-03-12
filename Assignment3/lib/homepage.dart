import 'package:chatapp/Profile.dart';
import 'package:chatapp/createChatUser.dart';
import 'package:chatapp/database_service.dart';
import 'package:chatapp/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/chatUsersModel.dart';
import 'package:chatapp/user.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.useruid})
      : super(key: key);
  final String title;
  
  final String useruid;
  @override
  State<MyHomePage> createState() => _MyHomePageState(currentuserid: this.useruid);
}

class _MyHomePageState extends State<MyHomePage> {
  late String currentuserid;
  _MyHomePageState({required this.currentuserid});
  int _currentIndex = 0;
  _onTap() { // this has changed
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => _children[_currentIndex])); // this has changed
  }
  

  final List<Widget> _children = [
    ChatPage(),
    showProfile(user: createChatUser().getcurrentuser(),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: "Profile"),
        ],
         onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _onTap();
        },
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
   
  List<ChatUsers> chatUsers = createChatUser().getalist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightBlue[50],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
              return ConversationList(
              name: chatUsers[index].name,
              messageText: chatUsers[index].messageText,
              image: chatUsers[index].image,
               time: chatUsers[index].time,
               isMessageRead: (index == 0 || index == 3)?true:false,
               user: chatUsers[index].user,
              );
              },
                ),
          ],
        ),
      ),
    );
  }


}
