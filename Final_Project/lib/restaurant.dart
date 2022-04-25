import 'dart:io';

import 'package:flutter/material.dart';

class restaurant {
  String name;
  String address;
  Image image; //Object type will be Image image;**/
  int likes;
  int dislikes;
  int shares;
  int miles;
  String? description;
  String? website;
  String? phone;
  String? email;
  restaurant(
      {required this.name,
      required this.address,
      required this.image,
      required this.likes,
      required this.dislikes,
      required this.shares,
      required this.miles,
      this.description,
       this.website,
       this.phone,
       this.email,});
}
