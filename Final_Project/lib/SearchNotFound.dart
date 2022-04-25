import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restaurant/main.dart';
//if app is unable to search input in database
class FunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: View(
        numberOfItems: 100,
      ),
    );
  }
}

class Item {
  static final random = Random();
  late double _size;
  late Color _color;

  late Alignment _alignment;

  Item() {
    _color = Color.fromARGB(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
    _alignment =
        Alignment(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1);
    _size = random.nextDouble() * 40 + 1;
  }
}

class View extends StatefulWidget {
  final int numberOfItems;

  const View({Key? key, required this.numberOfItems}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> with SingleTickerProviderStateMixin {
  var items = <Item>[];
  var started = false;

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                title: const Text("Go back"),
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
                child:  TextButton(
                  child: RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: 'Sorry, this search was not found\n',  style: TextStyle(fontSize: 40, color: Colors.grey, ),),
      TextSpan(
        text: '🥺', // emoji characters
        style: TextStyle(
          fontFamily: 'EmojiOne', fontSize: 40,
        ),
      ),
    ],
  ),
),
                  onPressed: makeItems,
                ),
              ),
            ),
            ...buildItems()
          ],
        ),
      ),
    );
  }

  List<Widget> buildItems() {
    return items.map((item) {
      var tween = Tween<Offset>(
              begin: Offset(0, Random().nextDouble() * -1 - 1),
              end: Offset(Random().nextDouble() * 0.5, 2))
          .chain(CurveTween(curve: Curves.linear));
      return SlideTransition(
        position: animationController.drive(tween),
        child: AnimatedAlign(
          alignment: item._alignment,
          duration: const Duration(seconds: 15),
          child: AnimatedContainer(
            duration: const Duration(seconds: 15),
            width: item._size,
            height: item._size,
            decoration:
                BoxDecoration(color: item._color, shape: BoxShape.circle ),
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
  }

  void makeItems() {
    setState(() {
      items.clear();
      for (int i = 0; i < widget.numberOfItems; i++) {
        items.add(Item());
      }
    });
    animationController.reset();
    animationController.forward();
  }
}