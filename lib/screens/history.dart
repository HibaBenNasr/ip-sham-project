import 'package:flutter/material.dart';
import 'package:sham_robot/widgets/flame_list.dart';
import 'package:sham_robot/widgets/hum_list.dart';
import 'package:sham_robot/widgets/smoke_list.dart';
import 'package:sham_robot/widgets/temp_list.dart';

class History extends StatefulWidget {
   final int indexx;
  const History({Key? key, required this.indexx}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState(indexx);
}

class _HistoryState extends State<History> {
  int indexx;
  _HistoryState(this.indexx);
  int _selectedIndex =0;
  final tabs= [
    HistoryTempList(),
    HistoryHumList(),
    HistorySmokeList(),
    HistoryFlameList(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      indexx = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs.elementAt(indexx),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Color.fromRGBO(42, 159, 244, 1),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        currentIndex: indexx,
        selectedIconTheme: IconThemeData(color: Colors.greenAccent, size: 40),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 10,
        onTap: _onItemTapped,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat_outlined),
            label: 'Temperature',
            backgroundColor: Color.fromRGBO(42, 159, 244, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water,),
            label: 'Humidity',
            backgroundColor: Color.fromRGBO(42, 159, 244, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud,),
            label: 'Gaz',
            backgroundColor: Color.fromRGBO(42, 159, 244, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot,),
            label: 'Flame',
            backgroundColor: Color.fromRGBO(42, 159, 244, 1),
          ),
        ],

      ),
    );
  }
}
