import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String displayName;
  final String role;
  final String firstname;
  final String lastname;
  final Timestamp timest;
  
  User({required this.id, required this.displayName, 
  required this.role, required this.firstname, required this.lastname,
  required this.timest});

  User.fromJson(String id, Map<String, dynamic> json) : this(
    id: id,
    displayName: json["display_name"],
    role: json["role"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    timest: json["registertime"]

  );

  Map<String, Object?> toJson(){
    return {
      "display_name" : displayName,
      "role" : role,
      "firstname": firstname,
      "lastname": lastname,
      "registertime": timest
    };
  }
}