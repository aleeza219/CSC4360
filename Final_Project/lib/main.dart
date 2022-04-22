import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:restaurant/AppInfo.dart';
import 'package:restaurant/searchResults.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Finders'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.restaurant),
          tooltip: 'logo',
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Finders")));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'profile',
            onPressed: () {
              // To show profile page of current user from firebase**/
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const showProfile(user: createChatUser().getcurrentuser(),)));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Greetings, foodies!',
              style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      <Color>[
                        Colors.red,
                        Colors.orangeAccent,
                      ],
                    )),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Find list of best restaurants around you',
              style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      <Color>[
                        Colors.blue,
                        Colors.green,
                      ],
                    )),
            ),
            const SizedBox(height: 30.0),
            Container(
                constraints: const BoxConstraints.expand(
                  width: 360,
                  height: 80,
                ),
                decoration: const BoxDecoration(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextField(
                    key: const Key('filter'),
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      labelText: 'Enter zipcode, city, or category',
                    ),
                  ),
                )),
            const SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const searchResults()));
                },
                child: const Text("SEARCH")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AppInfo()))),
        tooltip: 'About us',
        child: const Icon(Icons.chat),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
