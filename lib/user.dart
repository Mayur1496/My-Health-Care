import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:firebase_database/firebase_database.dart';

enum Gender{
  male,
  female
}

class User {

  String key;
  String email;
  String password;
  String name;
  String age;
  String phone;
  Gender gender;

  User(this.email, this.password, this.name, this.age, this.phone);

  User.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
        email = snapshot.value["email"],
        password = snapshot.value["password"],
        name = snapshot.value["name"],
        age = snapshot.value["age"],
        phone = snapshot.value["phone"];

  toJson(){
    return{
      "email":email,
      "password":password,
      "name":name,
      "age":age,
      "phone":phone,
    };
  }



}

Future<List<HealthData>> fetchHealthData(http.Client client) async {
  final response =
  await client.get('https://api.myjson.com/bins/g05ga');

  return compute(parseHealthData, response.body);
}

List<HealthData> parseHealthData(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed.map<HealthData>((json) => HealthData.fromJson(json)).toList();
}

class HealthData {
  double caloriesOut;
  int max;
  int min;
  int minutes;

  HealthData({this.caloriesOut, this.max, this.min, this.minutes});

  factory HealthData.fromJson(Map<String, dynamic> json){
    return HealthData(
      caloriesOut: json['caloriesOut'] as double,
      max: json['max'] as int,
      min: json['min'] as int,
      minutes: json['minutes'] as int
    );
  }
}