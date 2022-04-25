import 'package:flutter/material.dart';
import 'package:restaurant/Profile.dart';
import 'package:restaurant/Settings.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/restList.dart';
import 'package:restaurant/restaurant.dart';
import 'dart:ui' as ui;

class searchResults extends StatefulWidget {
  const searchResults({
    Key? key,
  }) : super(key: key);
  @override
  State<searchResults> createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> {
  _searchResultsState();
  int _currentIndex = 0;
  _onTap() {
    // this has changed
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            _children[_currentIndex])); // this has changed
  }

  final List<Widget> _children = [
    const listHelper(),
    const profile(), 
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const listHelper(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Restaurants",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: "Profile"),
        ],
        //tap on navigation bar contents
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _onTap();
        },
      ),
    );
  }
}

class listHelper extends StatefulWidget {
  const listHelper({Key? key}) : super(key: key);

  @override
  _listHelperState createState() => _listHelperState();
}

class _listHelperState extends State<listHelper> {
  // hard-coded restaurant list - integrate API here to assign values**/
  List<restaurant> Restaurants = [
    restaurant(
        name: "Dominos",
        address: "123 ABC street, atlanta, GA 30302",
        image: Image.asset("assets/images/dominos.png"),
        likes: 21,
        dislikes: 9,
        shares: 5,
        miles: 2,
        phone: "123-456(7890)",
        email: "abc@yahoo.com",
        website: "https://www.dominos.com/",
        description: "Our menu includes Pizzas, Sandwiches, Pastas, salads, desserts, breads, and drinks."),
    restaurant(
        name: "Chipotle",
        address: "456 XYZ street, atlanta, GA 30302",
        image: Image.asset("assets/images/food_black.jpg"),
        likes: 25,
        dislikes: 8,
        shares: 6,
        miles: 4,
        phone: "789-012(3456)",
        email: "xyz@yahoo.com",
        website: "https://www.chipotle.com/",
        description: "Our menu includes bowls, burritos, tacos, salads, and drinks."),
    restaurant(
        name: "Yogurt Land",
        address: "789 LMN street, atlanta, GA 30302",
        image: Image.asset("assets/images/yogurt_land.jpg"),
        likes: 10,
        dislikes: 5,
        shares: 1,
        miles: 3,
        phone: "456-123(7890)",
        email: "lmn@yahoo.com",
        website: "https://www.yogurt-land.com/",
        description: "Our menu includes yogurts with different kinds of flavors."),
    restaurant(
        name: "Lahore grill",
        address: "101 GHI street, atlanta, GA 30302",
        image: Image.asset("assets/images/lahore_grill.png"),
        likes: 15,
        dislikes: 2,
        shares: 3,
        miles: 5,
        phone: "789-045(6123)",
        email: "ghi@yahoo.com",
        website: "https://lahoregrill.com/",
        description: "We offer Pakistani and North Indian cuisine to all who would love to try Authentic Food. Our cuisine is vast and mouth-watering."),
    restaurant(
        name: "Halal guys",
        address: "224 ABC street, atlanta, GA 30302",
        image: Image.asset("assets/images/halal_guys.png",
                       // width: 300,
                        height: 150,
                        fit:BoxFit.fill

                    ),
        likes: 50,
        dislikes: 2,
        shares: 10,
        miles: 10,
        phone: "198-765(4321)",
        email: "cba224@yahoo.com",
        website: "https://thehalalguys.com/",
        description: "Chicken, Gyros, and Falafel Platters. The Authentic American Halal Food. Since 1990."),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Finders", style: TextStyle(fontSize: 25,)),
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
      body: 
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/food_white.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Search Results",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: Restaurants.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card( child: restList(
                  name: Restaurants[index].name,
                  address: Restaurants[index].address,
                  image: Restaurants[index].image,
                  likes: Restaurants[index].likes,
                  dislikes: Restaurants[index].dislikes,
                  shares: Restaurants[index].shares,
                  miles: Restaurants[index].miles,
                  res: Restaurants[index]
                ));
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
