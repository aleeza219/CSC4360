import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanspage/database_service.dart';
import 'package:fanspage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class register extends StatefulWidget{
  const register({Key? key, required String title}) : super(key: key);

  @override
  State<register> createState() => _register();
}

// ignore: camel_case_types
class _register extends State<register>{
  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _password = TextEditingController();
  final _confpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold (                     // Add from here... 
      appBar: AppBar(
        title: const Text('Registration'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'go back',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homepage(title: '',)));
            },
          ),
      ),
      body: Center(child: _registerpage(),)
    );                                      // ... to here.
  }

 // ignore: non_constant_identifier_names
  Widget _registerpage(){
    if (_loading) {
      return const LoadingPage();
    } else {
      return Center(
      child: Form(
        key: _formKey,
        child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0),
          TextFormField(controller: _firstname,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.person),
            labelText: 'First Name*'
          ),
          validator: (String? text){
            if (text == null || text.isEmpty){
              return "Please enter First Name";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          TextFormField(controller: _lastname,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.person),
            labelText: 'Last Name*'
          ),
          validator: (String? text){
            if (text == null || text.isEmpty){
              return "Please enter Last Name";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          TextFormField(controller: _username,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.person),
            labelText: 'Username*'
          ),
          validator: (String? text){
            if (text == null || text.isEmpty){
              return "Please enter username";
            }else if (DatabaseService.usernames.contains(text.toLowerCase())){
              return "This username is already in use";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          TextFormField(controller: _email,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.email),
            labelText: 'Email*'
          ), 
          validator: (String? text){
            if (text == null || text.isEmpty){
              return "Please enter email address";
            }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text)){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid email")));
              return "Invalid email";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          TextFormField(controller: _password,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.lock_open),
            labelText: 'Password*'
          ),
          validator: (String? text){
            if (text == null || text.length < 6){
              return "Your password must conatin six characters";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          TextFormField(controller: _confpassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.lock_open),
            labelText: 'Confirm password*'
          ), 
          validator: (String? text){
            if (text == null || text.length < 6){
              return "Your password must conatin six characters";
            }else if(text != _password.text){
              return "passwords do not match";
            }
            return null;
          }),
          const SizedBox(height: 15.0),
          ElevatedButton(onPressed: (){
            setState(() {
              //_loading = true;
              registerUser(context);
            });
            }, 
          child: const Text("register")), 
          
        ],),
        ),
    //),
    );
    }
  }

  void registerUser(BuildContext context) async{
  if (_formKey.currentState!.validate()){
    try {
      await _auth.createUserWithEmailAndPassword(email: _email.text, password: _password.text);{
      }
    }on FirebaseAuthException catch(e){
      if (e.code == "wrong-password" || e.code == "no-email"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
      }
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    try {
      if (_auth.currentUser != null){
        await _db.collection("users").doc(_auth.currentUser!.uid).set(
          {
            "display_name": _username.text,
            "role": "USER",
             "email": _email.text,
            "firstname": _firstname.text,
            "lastname": _lastname.text,
            "registertime": Timestamp.now()
          }
        );
        const Text("Registration is complete");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const homepage(title: 'Aleeza\'s Fans'))));
      }
    } on FirebaseException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Unknown Error")));
      }
    }
  }
}

