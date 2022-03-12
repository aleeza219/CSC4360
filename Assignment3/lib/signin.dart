
import 'package:chatapp/homepage.dart';
import 'package:chatapp/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class Login extends StatefulWidget{
  const Login({Key? key, required String title}) : super(key: key);

  @override
  State<Login> createState() => _SignIn();
}

class _SignIn extends State<Login>{
  // ignore: prefer_final_fields
  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (                     // Add from here... 
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Center(child: _SignInpage(),)
    );                                      // ... to here.
  }

 // ignore: non_constant_identifier_names
  Widget _SignInpage(){
    if (_loading) {
      return const LoadingPage();
    } else {
      return Center(
      child: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          TextFormField(controller: _email, 
          decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade300,
            icon: const Icon(Icons.email),
            labelText: 'Enter Email*'
          ),
          validator: (String? text){
            if (text == null || text.isEmpty){
              return "Please enter email address";
            }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text)){
              return "Invalid email";
            }
            return null;
          }),
          const SizedBox(height: 25.0),
          TextFormField(controller: _password, 
           decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)),
            fillColor: Colors.grey.shade800,
            icon: const Icon(Icons.lock_open),
            labelText: 'Enter password*'
          ),
          validator: (String? text){
            if (text == null || text.length < 6){
              return "Your password must conatin six characters";
            }
            return null;
          }),
          const SizedBox(height: 25.0),
          ElevatedButton(onPressed: (){
            setState(() {
              //_loading = true;
              logIn(context);
            });
            }, 
          child: const Text("Log In")),
          ElevatedButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const register(title: 'Register as a User',)));
          }, 
          child: const Text("Register")),
          TextButton(onPressed: (){
 
          }, 
          child: const Text("Forgot Password")),
        ],),
        ),
    //),
    );
    }
  }

  void logIn(BuildContext context) async{
  if (_formKey.currentState!.validate()){
    try {
      await _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(title: '', useruid: _auth.currentUser!.uid,)));
    }on FirebaseAuthException catch(e){
      if (e.code == "wrong-password" || e.code == "no-email"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
      }
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    
}

}
}

class LoadingPage extends StatelessWidget{
  const LoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return const Center(child: CircularProgressIndicator());
  } 
}