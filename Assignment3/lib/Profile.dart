import 'package:chatapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/user.dart' as a;
import 'package:chatapp/createChatUser.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: camel_case_types
class showProfile extends StatefulWidget {
  const showProfile({Key? key, this.user}) : super(key: key);
  final a.User? user;

  @override
  State<showProfile> createState() => _Profile(user: this.user);
}

class _Profile extends State<showProfile> {
  late a.User? user;
  _Profile({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Add from here...
        appBar: AppBar(
          title: const Text('Chat App'),
          actions:[
    IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      tooltip: 'logout',
      onPressed: () {
        _PopUp();
      },
    )
  ], 
        ),
        body: Center(
          child: _displayInfo(),
          
        )); // ... to here.
  }

  Widget _displayInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5.0, 50, 5.0), 
      child: Card(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(height: 50.0),RatingBar.builder(
   initialRating: 3,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
const SizedBox(height: 50.0),
          Center(
              child: Text("Name: " +
                  user!.firstname.toUpperCase() +
                  " " +
                  user!.lastname.toUpperCase())),
          const SizedBox(height: 30.0),
          Center(child: Text("Username: " + user!.displayName)),
          const SizedBox(height: 30.0),
          Center(child: Text("Email Address: " + user!.email)),
          const SizedBox(height: 50.0),
          // Center(
          //     child: ElevatedButton(
          //         onPressed: () {
          //           setState(() {
          //             _PopUp();
          //           });
          //         },
          //         child: const Text("Sign Out"))),
          const SizedBox(height: 50.0),
        ],
      ),
    ));
  }

  // ignore: non_constant_identifier_names
  void _PopUp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text(""),
          content: const Text("Are you sure to log out?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  logout();
                },
                child: const Text('Confirm')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ]),
    );
  }

  Future logout() async {
    final FirebaseAuth _auth = FirebaseAuth.instance; 
    await _auth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login(title: '')),
            (route) => false));
  }
}
