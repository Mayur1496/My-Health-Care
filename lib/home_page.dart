import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_health_care/user.dart';
import 'package:my_health_care/login_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  static String tag = 'home-page';

  @override
  createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage>{

  static List data;
  int restingHeartRate;
  HealthData outOfRange = new HealthData();
  HealthData fatBurn = new HealthData();
  HealthData cardio = new HealthData();
  HealthData peak = new HealthData();


  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  Future<String> getSWData() async {
    var res = await http
        .get("https://api.myjson.com/bins/g05ga");

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["activities-heart"];
      if(data==null)
        print(".........failed........");
      else{
        restingHeartRate = data[0]["value"]["restingHeartRate"];
        outOfRange.setData(
            data[0]["value"]["heartRateZones"][0]["minutes"],
            data[0]["value"]["heartRateZones"][0]["max"],
            data[0]["value"]["heartRateZones"][0]["min"]
        );
        fatBurn.setData(
            data[0]["value"]["heartRateZones"][1]["minutes"],
            data[0]["value"]["heartRateZones"][1]["max"],
            data[0]["value"]["heartRateZones"][1]["min"]
        );
        cardio.setData(
            data[0]["value"]["heartRateZones"][2]["minutes"],
            data[0]["value"]["heartRateZones"][2]["max"],
            data[0]["value"]["heartRateZones"][2]["min"]
        );
        peak.setData(
            data[0]["value"]["heartRateZones"][3]["minutes"],
            data[0]["value"]["heartRateZones"][3]["max"],
            data[0]["value"]["heartRateZones"][3]["min"]
        );
      }
    });

    return "Success!";
  }

  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, ModalRoute.withName(LoginPage.tag));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Dashboard')
        ),
        body: new Container(
          padding: const EdgeInsets.all(15.0),
          child: new ListView(
            children: <Widget>[
              new Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlueAccent
                  ),
                  child: new SizedBox(
                      width: 400.0,
                      height: 120.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('images/banner.jpg'),
                            fit: BoxFit.fill,
                        )
                      ),
                    ),
                  )),                                 //Add image,barrel in place of this container
              const SizedBox(height:15.0),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text('Average Heart Rate', style: new TextStyle(decoration:TextDecoration.underline,decorationStyle: TextDecorationStyle.double ,color: Colors.red,fontSize: 22.0,fontStyle: FontStyle.italic, ),textAlign: TextAlign.center,),
                    new Text(restingHeartRate.toString(),style: new TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 35.0,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),   //Add Average Heart Rate in place of 65
                  ],
                ),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.red),
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(height:15.0),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Out of Range',style: new TextStyle(decoration:TextDecoration.underline ,fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.center)),
                  new Expanded(child: new Text('Fat Burn',style: new TextStyle(decoration:TextDecoration.underline ,fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.center))
                ],
              ),
              const SizedBox(height:10.0),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Time:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(outOfRange.minutes.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),     //Add time from JSON in place of mins
                  new Expanded(child: new Text('Time:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(fatBurn.minutes.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))      //Add time from JSON in place of mins
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Max:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(outOfRange.max.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),             //Add heart rate from JSON inplace of HR
                  new Expanded(child: new Text('Max:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(fatBurn.max.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))              //Add heart rate from JSON inplace of HR
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Min:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(outOfRange.min.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),           //Add heart rate from JSON inplace of HR
                  new Expanded(child: new Text('Min:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(fatBurn.min.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))            //Add heart rate from JSON inplace of HR
                ],
              ),
              const SizedBox(height:10.0),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Cardio',style: new TextStyle(decoration:TextDecoration.underline ,fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.center)),
                  new Expanded(child: new Text('Peak',style: new TextStyle(decoration:TextDecoration.underline ,fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.center))
                ],
              ),
              const SizedBox(height:10.0),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Time:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(cardio.minutes.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),        //Add time from JSON in place of mins
                  new Expanded(child: new Text('Time:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(peak.minutes.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))        //Add time from JSON in place of mins
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Max:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(cardio.max.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),           //Add heart rate from JSON inplace of HR
                  new Expanded(child: new Text('Max:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(peak.max.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))            //Add heart rate from JSON inplace of HR
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(child: new Text('Min:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(cardio.min.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center)),          //Add heart rate from JSON inplace of HR
                  new Expanded(child: new Text('Min:',style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center),),
                  new Expanded(child: new Text(peak.min.toString(),style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.center))          //Add heart rate from JSON inplace of HR
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: new Text(' ') ,// Add the image sent along in the mail
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('images/drawer.jpg'),
                          fit: BoxFit.fill
                      ),
                    )
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap:(){
                    //Add the profile diversion code here
                  },
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: (){
                    signout();//Add the sign out code here
                  },
                ),
              ],
            )
        )
    );
  }
}
