import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sham_robot/screens/history.dart';
import 'package:sham_robot/widgets/appbar.dart';
import 'package:sham_robot/widgets/drawer.dart';
import 'package:sham_robot/widgets/sensor_card.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<double>? tempList= [16,12,15,19,18];
  List<double>? humList = [80,69,40,50,74];
  List<double>? smkList = [200,220,250,222,320];
 // var ll;
  String hum='';
  String temp='';
  String smk='';
  bool flameState=false;
  bool tempState=false;
  bool smkState=false;
  final database =FirebaseDatabase.instance.reference();

  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners();
  }
  void _activateListeners(){
    database.child("detection/humidity/value").onValue.listen((event) {
      var des=event.snapshot.value;
      setState(() {
        hum=des.toString();
      });
    });
    database.child("detection/smoke/value").onValue.listen((event) {
      var des=event.snapshot.value;
      setState(() {
        smk=des.toString();
      });
    });
    database.child("detection/smoke/state").onValue.listen((event) {
      var des=event.snapshot.value;
      setState(() {
        smkState=des;
      });
    });
    database.child("detection/temperature/value").onValue.listen((event) {
       var des=event.snapshot.value;
      setState(() {
        temp=des.toString();
      });
    });
    database.child("detection/temperature/state").onValue.listen((event) {
      var des=event.snapshot.value;
      setState(() {
        tempState=des;
      });
    });
    database.child("detection/flame/state").onValue.listen((event) {
      var des=event.snapshot.value;
      setState(() {
        flameState=des;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: kMainBG,
      appBar: customAppBar("dashboard"),
        drawer: MainDrawer(),
        body: Padding(
              padding:
              const EdgeInsets.only(left: 0, right: 0, top: 0, ),
              child: CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MySensorCard(
                                    value: temp,
                                    unit: '\'C',
                                    name: 'Temperature',
                                    assetImage: AssetImage(
                                      'assets/images/temperature_icon.png',
                                    ),
                                    trendData: tempList!,
                                    linePoint: Colors.redAccent,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MySensorCard(
                                    value: hum,
                                    unit: '%',
                                    name: 'Humidity',
                                    assetImage: AssetImage(
                                      'assets/images/humidity_icon.png',
                                    ),
                                    trendData: humList!,
                                    linePoint: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MySensorCard(
                                    value: smk,
                                    unit: '',
                                    name: 'Smoke',
                                    assetImage: AssetImage(
                                      'assets/images/smoke_icon.png',
                                    ),
                                    trendData: smkList!,
                                    linePoint: Colors.purple,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
      bottomSheet: flameState || smkState || tempState?Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(

            color: Colors.red,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if(flameState)...[
              Text("Flame Detected"),
              IconButton(icon: Icon(Icons.navigate_next), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => History(indexx: 3,))),),
            ]else if(smkState)...[
              Text("Smoke Detected"),
              IconButton(icon: Icon(Icons.navigate_next), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => History(indexx: 2,))),),
            ]else if(tempState)...[
              Text("High Tempreture Detected"),
              IconButton(icon: Icon(Icons.navigate_next), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => History(indexx: 0,))),),

            ],

          ],
        ),
      ):SizedBox.shrink()
        );
  }
}