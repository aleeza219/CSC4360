import 'package:fanspage/mainpage.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);
  @override
  _splashScreen createState() => _splashScreen();
}

// ignore: camel_case_types
class _splashScreen extends State<splashScreen>{
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

   _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const homepage(title: 'Aleeza\'s Fans'))));
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/SplashScreen.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
     ),
   )
   );
  }
}