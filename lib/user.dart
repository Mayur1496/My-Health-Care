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

class HealthData {
  int max;
  int min;
  int minutes;

  setData(minutes, max, min){
    this.minutes = minutes;
    this.max = max;
    this.min = min;
  }

}


