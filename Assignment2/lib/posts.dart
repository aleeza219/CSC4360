import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanspage/database_service.dart';
import 'package:fanspage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  State<Posts> createState() => _UserListState();
}

class _UserListState extends State<Posts> {
  String time = "?";
  var now;
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String,dynamic> posted = <String, dynamic>{};
  //List<posted> displayposts = <posted>[];
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See all Posts'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'go back',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homepage(title: '',)));
            },
          ),
      actions:[
    IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      tooltip: 'logout',
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const homepage(title: 'Aleeza\'s Fans'))));
      },
    )
  ], 
      ),
      floatingActionButton: DatabaseService.userMap[_auth.currentUser!.uid]?.role == "ADMIN" ? FloatingActionButton(onPressed: (){
       // addPost();
      
      },
      child: IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'add post',
            onPressed: () {
               _showPopUp();
            },),
      ) : null,
      body: StreamBuilder<QuerySnapshot>(
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong querying users");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              var post = doc.data() as Map<String,dynamic>;
            return Card(child: ListTile(
              title: Text(post["message"]),
              //trailing: const Text('testing'),
              trailing:  Text(post["postdate"]),
            ),
            );
          }).toList());
        },
      ),
    );
  }

  void addPost(String message) async{  
    now = DateTime.now();
    time = DateFormat('MM-dd-yyyy, kk:mm').format(now);
    await _db.collection("posts").add(
          {  
            "message" : message,
            "postby" : DatabaseService.userMap[_auth.currentUser!.uid]!.displayName.toString(),
            "postdate": time
          });
  }

  void _showPopUp(){
    var _newPost = TextEditingController();
  showDialog(
    
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Enter post"),
    content: TextFormField(controller: _newPost,
    
          validator: (String? text){
            if (text == null || text.length < 6){
              return "Your password must conatin six characters";
            }
            return null;
          }),
     actions: [
       TextButton(onPressed: (){
         if (_newPost.text.isNotEmpty){
              addPost(_newPost.text);
          }
         Navigator.of(context).pop();
       }, child: const Text('post')),
       TextButton(onPressed: (){
         Navigator.of(context).pop();
       }, child: const Text('Close'))
     ]
    ),
  );
  }
}

