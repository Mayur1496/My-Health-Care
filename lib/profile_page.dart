
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_health_care/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {

  static String tag =  'profile';

  @override
  State<StatefulWidget> createState() => new _Profile();
}

class _Profile extends State<Profile>{

  User currentUser = new User("","","","","");
  StreamSubscription subscriptionUser;

  @override
  void initState(){
    super.initState();
    getUser();
  }

  getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //print('userid is ${user.uid}');
    getCurrentUser(user.uid.toString())
        .then(updateUser);
  }

  updateUser(User value){
    var user = value;
    setState(() {
      currentUser = user;
      //print('User $currentUser');
    });
  }

  Future<User> getCurrentUser(String userKey) async {
    Completer<User> completer = new Completer<User>();
    FirebaseDatabase.instance
        .reference()
        .child("user")
        .child(userKey)
        .once()
        .then((DataSnapshot snapshot) {
      var user = new User.fromSnapshot(snapshot);
      completer.complete(user);
    });

    return completer.future;
  }

  @override
  void dispose() {
    if (subscriptionUser != null) {
      subscriptionUser.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text(currentUser.name.toString()),
            ),
            ListTile(
              title: Text(currentUser.age.toString()),
            ),
            ListTile(
              title: Text(currentUser.phone.toString()),
            ),
            ListTile(
              title: Text(currentUser.email.toString()),
            ),
          ],
        )
    );
  }
}


