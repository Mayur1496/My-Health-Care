import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  static String tag = 'home-page';

  @override
  createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:
          Text(
            'HomePage',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ) ,
          )
      )
    );
  }
}