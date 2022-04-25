import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/Profile.dart';
import 'package:restaurant/main.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:restaurant/searchResults.dart';
import 'package:carousel_slider/carousel_slider.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingState();
}

class _settingState extends State<settings> {
  final List<String> imgList = [
  'https://i.ibb.co/wJYXXM5/yogurt-land.jpg',
  'https://i.ibb.co/8dCbRYQ/lahore-grill.png',
   'https://i.ibb.co/bRCM60T/food-white.jpg',
   'https://i.ibb.co/f10HKC5/food-black.jpg',
   'https://i.ibb.co/QXbtQn3/halal-guys.png',
   'https://i.ibb.co/cyQV12H/dominos.png'
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontSize: 20,),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25),
          tooltip: 'go back',
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Finders")));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40.0),
            ElevatedButton(
                onPressed: () {
                  displayAlert(context);
                },
                child: const Text("See what's new")),
             
                const SizedBox(height: 40.0), 
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const profile()));
                },
                child: const Text("Profile")), 
                const SizedBox(height: 80.0),  
                const Text(
                      "Recommendations",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                     const SizedBox(height: 20.0),
               Container(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child:
                          Image.network(item, fit: BoxFit.cover, width: 1000)),
                ))
            .toList(),
      )),
     
          ],
        ),
      ),
    );
  }

   displayAlert(context) {
    EmojiAlert(
      cancelable: true,
        description: Column(
      children: const [
        Text("Please sign up.."),
        Text("Add restaurants to your favorites"),
         Text("And leave reviews on restaurants"),
      ],
    ),
    enableMainButton:  true,
	cornerRadiusType:  CORNER_RADIUS_TYPES.TOP_ONLY,
	mainButtonColor:  Colors.blue,
	mainButtonText:  Text("Sign Up"),
	onMainButtonPressed: () {
		//navigator for signup page
	},
  height:  300,
    animationType: ANIMATION_TYPE.TRANSITION,).displayAlert(context);
  }
  
}
