import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/SearchNotFound.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/searchResults.dart'; //userinfo from firebase_auth + logOut
//In this class, we will pass user as a required argument 

// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profile();
}

class _profile extends State<profile> {
  _profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontSize: 25,),),
         leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 25),
            tooltip: 'go back',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Finders")));
            },
          ),
          actions:[
    TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {_PopUp();},
                  child: const Text('Sign Out'),
                ),
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
        children:  <Widget>[
const SizedBox(height: 50.0),
          const Center(
              child: const Text("Name: "),),
           const SizedBox(height: 30),
          const Center(child: Text("Username: " )),
          const SizedBox(height: 30.0),
          const Center(child: Text("Email Address: " )),
          const SizedBox(height: 50.0),
           Center( child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  FunPage()));
                },
                child: const Text("Favorites")),),
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
                  //logout();
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Finders")));
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

  // Future logout() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance; 
  //   await _auth.signOut().then((value) => Navigator.of(context)
  //       .pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => const Login(title: '')),
  //           (route) => false));
  // }
}
