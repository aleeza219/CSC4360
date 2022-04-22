import 'package:flutter/material.dart';
import 'package:restaurant/main.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  State<AppInfo> createState() => _AboutUs();
}

class _AboutUs extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            const Text(
              " This app is intended to find restaurants around you\n\n We provide you best results based on:\n Location\n Ratings\n Category (such as Pizza, mediterranean, indian, etc)\n dietary restrictions (such as halal, vegan, etc)",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  _showPopUp();
                },
                child: const Text("Share Feedback")),
          ],
        ),
      ),
    );
  }

  void _showPopUp() {
    var _newPost = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Enter your feedback to share with app developers"),
          content: TextFormField(
            controller: _newPost,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_newPost.text.isNotEmpty) {
                    //add firebase to store messages
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Send')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'))
          ]),
    );
  }
}
