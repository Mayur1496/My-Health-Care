import 'package:flutter/material.dart';
import 'package:my_health_care/user.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  static String tag = 'home-page';

  @override
  createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    String title = 'Home-Page';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: FutureBuilder<List<HealthData>>(
          future: fetchHealthData(http.Client()),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? Dashboard(healthData: snapshot.data)
                : Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

class Dashboard extends StatelessWidget{
  final List<HealthData> healthData;
  Dashboard({Key key, this.healthData}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Text(
            healthData[0].caloriesOut.toString()
          ),
          Text(
            healthData[0].min.toString()
          )
        ],
      ),
    );
  }
}