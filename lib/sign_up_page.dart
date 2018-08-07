import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:my_health_care/user.dart';

class SignUpPage extends StatefulWidget{

  static String tag = 'sign-up-page';

  @override
  State<StatefulWidget> createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  User user;
  DatabaseReference userRef;
  FirebaseDatabase database;
  bool success = false;
  FocusNode _focusNode1 = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();
  FocusNode _focusNode4 = new FocusNode();
  FocusNode _focusNode5 = new FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    user = User("","","","","");
    database = FirebaseDatabase.instance;
    _focusNode4.addListener(_focusNodeListener);
    //userRef = database.reference().child("user");
  }
  @override
  void dispose(){
    _focusNode4.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode4.hasFocus){
      print('TextField got the focus');
    } else {
      print('TextField lost the focus');
    }
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      //success = true;
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> validateAndSubmit(email,password) async{
    if(validateAndSave()){
      try {
        FirebaseUser currUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        userRef = database.reference().child("user").child(currUser.uid);
        userRef.set(user.toJson());
        //userRef.push().set(user.toJson());
        //success = true;
        print('User Created: ${currUser.uid}');
        return true;

      }catch(e){
        print('Error $e');
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Sign Up Form'),
      ),
      body: new SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Name'),
                  validator: (value)=> value.isEmpty ? 'Name cannot be Empty':null,
                  onSaved: (value) => user.name=value,
                  focusNode: _focusNode1,
                ),
                new SizedBox(
                  height: 16.0,
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Gender',textAlign: TextAlign.left,)
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Expanded(
                        child: new RadioListTile<Gender>(
                          title: const Text('Male'),
                          value: Gender.male,
                          groupValue: user.gender,
                          onChanged: (Gender value) { setState(() { user.gender = value; }); },
                        ),
                    ),
                    new Expanded(
                      child: new RadioListTile<Gender>(
                        title: const Text('Female'),
                        value: Gender.female,
                        groupValue: user.gender,
                        onChanged: (Gender value) { setState(() { user.gender = value; }); },
                      ),
                    ),
                  ],
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Age'),
                  validator: (value)=> value.isEmpty ? 'Age cannot be Empty':null,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => user.age=value,
                  focusNode: _focusNode2,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Phone'),
                  validator: (value)=> value.isEmpty ? 'Name cannot be Empty':null,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => user.phone=value,
                  focusNode: _focusNode3,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  validator: (value)=> value.isEmpty ? 'Email cannot be Empty':null,
                  onSaved: (value) => user.email=value,
                  focusNode: _focusNode4,
                ),
                new TextFormField(
                  decoration:  new InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value)=> value.isEmpty ? 'Password cannot be Empty':null,
                  onSaved: (value) => user.password=value,
                  focusNode: _focusNode5,
                ),
                new Padding(padding: new EdgeInsets.all(8.0)),
                new RaisedButton(
                  child: new Text('Sign Up', style: new TextStyle(fontSize: 20.0)),
                  onPressed:()async{
                    formKey.currentState.save();
                    success= await validateAndSubmit(user.email, user.password);
                    if(success){
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text(
                              'Sign Up Successful. Please Login to continue.'),
                            duration: Duration(seconds: 5),
                          )
                      );
                      Future.delayed(const Duration(seconds:3), () {
                        Navigator.of(context).pop();
                      });
                    }else{
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text(
                              'Please enter valid details'),
                            duration: Duration(seconds: 5),
                          )
                      );
                    }
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}

