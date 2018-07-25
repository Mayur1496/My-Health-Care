import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_health_care/home_page.dart';
import 'dart:async';

import 'package:my_health_care/start_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  
  bool validateAndSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              content: Text('Please enter valid email')
          )
      );
      return false;
    }
  }
  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print('Signed in: ${user.uid}');
        Navigator.of(context).pushNamed(HomePage.tag);
        }catch(e){
        print('Error $e');
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
                content: Text('Invalid Credentials')
            )
        );
      }
    }
  }

  void sendForgotPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
    }catch(e){
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('images/app_home.jpg'),
            fit: BoxFit.fill
          ),
        ),
        child: Form(
          key: formkey,
            child: ListView(
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 200.0),
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        key: new Key('email'),
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)
                          ),
                        ),
                        autocorrect: false,
                        validator: (val) => !val.contains('@')?'Please enter a valid Email':null,
                        onSaved: (val) => _email = val,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        key: new Key('password'),
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)
                          ),
                        ),
                        autocorrect: false,
                        //validator: (val) => val.length<6?'Too short password':null,
                        obscureText: true,
                        onSaved: (val) => _password = val,
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0,horizontal: 70.0),
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
                              onPressed:(){
                                validateAndSubmit();
                              },
                            ),
                          )
                      ),
                      FlatButton(
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.black45, fontSize: 14.0),
                        ),
                        onPressed: () {
                          validateAndSave();
                          sendForgotPassword();
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text('Password reset link sent to $_email')
                              )
                          );
                        },
                      )
                    ],
                  ),
                ]
            )
        ),
      ),
    );
  }

}