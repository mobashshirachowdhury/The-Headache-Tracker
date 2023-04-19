import 'package:flutter/material.dart';
import '';
class userfile {
  String user_id;
  String user_name;
  String email;
  String password;
  String user_gender;

  userfile(this.user_id, this.user_name, this.email,
      this.password, this.user_gender);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password,
      'user_gender': user_gender
    };
    return map;
  }
  userfile.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    email = map['email'];
    password = map['password'];
    user_gender = map['user_gender'];
  }
}