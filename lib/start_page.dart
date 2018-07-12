import 'package:flutter/material.dart';
import 'package:my_health_care/sign_up_page.dart';
import 'package:my_health_care/login_page.dart';

class StartPage extends StatefulWidget {
  static String tag = 'start-page';

  @override
  createState() => new _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    Widget messageTitle = RichText(
      text: TextSpan(
        text: 'My Health Care',
        style: TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
            fontFamily: 'IBMPlexSerif'),
      ),
      textAlign: TextAlign.center,
    );

    Widget logo = Padding(
      padding: EdgeInsets.all(16.0),
      child: CircleAvatar(
        radius: 72.0,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('images/red_cross.png'),
      ),
    );

    Widget loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: MaterialButton(
            minWidth: 250.0,
            height: 48.0,
            color: Colors.lightBlueAccent,
            child: Text('Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontFamily: 'IBMPlexSerif',
                )),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginPage.tag);
            },
          ),
        )
    );

    Widget signUpLabel = FlatButton(
      child: Text(
        'New User? Sign Up here',
        style: TextStyle(color: Colors.black45, fontSize: 14.0),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpPage.tag);
      },
    );

    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('images/app_home.jpg'),
              fit: BoxFit.fill
          )
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 52.0),
            messageTitle,
            SizedBox(height: 24.0),
            logo,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 18.0),
            signUpLabel,
          ],
        ),
      ),
    ));
  }
}
