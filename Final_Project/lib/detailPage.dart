import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant/Settings.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/restaurant.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: camel_case_types
class detailPage extends StatefulWidget {
  const detailPage({Key? key, required this.Res}) : super(key: key);
  final restaurant Res;

  @override
  State<detailPage> createState() => _detailPageState(Res: Res);
}

class _detailPageState extends State<detailPage> {
  restaurant? Res;
  _detailPageState({this.Res});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Finders", style: TextStyle(fontSize: 25,),),
         leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 25),
            tooltip: 'go back',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Finders")));
            },
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 40),
            padding: const EdgeInsets.only(right: 7),
            tooltip: 'settings',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const settings()));
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
        padding: const EdgeInsets.fromLTRB(5, 5.0, 5, 10.0),
        child: Card(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
          margin:const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("image"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset("assets/images/food_black.jpg",
                       // width: 300,
                        height: 150,
                        fit:BoxFit.fill

                    ),
                  ),
                  ListTile(
                     title: Text(Res!.name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    subtitle: Text(Res!.address, style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ),
        ),
              //const SizedBox(height: 50.0),
              
              const SizedBox(height: 30.0),
              const Center(child:  Text("Contact Info: ",style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
              const SizedBox(height: 15.0),
               Center(child: Text(Res!.phone.toString(),style: const TextStyle(fontSize: 15.0, color: Colors.blue))),
              Center(child:Text(Res!.website.toString(),style: const TextStyle(fontSize: 15.0, color: Colors.blue),)),
              Center(child:Text(Res!.email.toString(),style: const TextStyle(fontSize: 15.0, color: Colors.grey))),
              const SizedBox(height: 30.0),
              const Center(child:  Text("Description: ",style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
              const SizedBox(height: 15.0),
               Padding(
                padding: const EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),child: Text(Res!.description.toString(),style: const TextStyle(fontSize: 15.0, color: Colors.grey))),
              const SizedBox(height: 50.0),
              Center(child: RatingBar.builder(
                initialRating: 4,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )),
              const SizedBox(height: 50.0),
              TextButton(
                  onPressed: () {
                    _showPopUp();
                  },
                  child: const Text("Leave a review...")),
            ],
        )));
  }

  void _showPopUp() {
    var _newPost = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Comment"),
          content: TextFormField(
              controller: _newPost,
              validator: (String? text) {
                if (text == null || text.length < 6) {
                  return "Your password must conatin six characters";
                }
                return null;
              }),
          actions: [
            TextButton(
                onPressed: () {
                  if (_newPost.text.isNotEmpty) {
                    addPost(_newPost.text);
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('post')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'))
          ]),
    );
  }

  var now;
  var time;
  void addPost(String message) async {
    now = DateTime.now();
    time = DateFormat('MM-dd-yyyy, kk:mm').format(now);
    //stored in firestore
    //   await _db.collection("posts").add(
    //         {
    //           "message" : message,
    //           "postdate": time
    //         });
    // }
  }
}
