import 'package:flutter/material.dart';
import 'package:my_health_care/start_page.dart';
import 'package:my_health_care/login_page.dart';
import 'package:my_health_care/sign_up_page.dart';
import 'package:my_health_care/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final routes = <String, WidgetBuilder>{
      StartPage.tag: (context) => StartPage(),
      LoginPage.tag: (context) => LoginPage(),
      SignUpPage.tag: (context) => SignUpPage(),
      HomePage.tag: (context) => HomePage(),

    };

    return MaterialApp(
      title: 'Health Care',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'IBMPlexSerif'
      ),
      home: StartPage(),
      routes: routes,
    );
  }
}

