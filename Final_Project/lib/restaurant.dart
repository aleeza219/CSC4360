import 'package:flutter/material.dart';

class restaurant {
  String name;
  String address;
  String image; //Object type will be Image image;**/
  int likes;
  int dislikes;
  int shares;
  int miles;
  restaurant(
      {required this.name,
      required this.address,
      required this.image,
      required this.likes,
      required this.dislikes,
      required this.shares,
      required this.miles});
}
