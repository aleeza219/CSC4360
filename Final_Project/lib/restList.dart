import 'package:flutter/material.dart';
import 'package:restaurant/detailPage.dart';
import 'package:restaurant/restaurant.dart';
import 'package:restaurant/main.dart';

class restList extends StatefulWidget {
  String name;
  String address;
  Image image;
  int likes;
  int dislikes;
  int shares;
  int miles;
  restaurant res;
  restList(
      {Key? key,
      required this.name,
      required this.address,
      required this.image,
      required this.likes,
      required this.dislikes,
      required this.shares,
      required this.miles,
      required this.res})
      : super(key: key);

  @override
  State<restList> createState() => _fullList();
}

class _fullList extends State<restList> {
  //late restaurant Res;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // To tap on each individual restaurant from list**/
      onTap:()
      async {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return detailPage(Res: this.widget.res);
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image.toString()),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.address,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Icon(Icons.thumb_up_sharp, size: 14),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(widget.likes.toString()),
                              ),
                              const Icon(Icons.thumb_down_sharp, size: 14),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(widget.dislikes.toString()),
                              ),
                              const Icon(Icons.share_sharp, size: 14),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(widget.shares.toString()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.miles.toString() + " mi",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
