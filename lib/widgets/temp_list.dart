import 'package:expandable/expandable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sham_robot/const/styles.dart';
import 'package:sham_robot/widgets/appbar.dart';
import 'package:sham_robot/widgets/drawer.dart';

import '../methods.dart';

class HistoryTempList extends StatefulWidget {
  const HistoryTempList({Key? key}) : super(key: key);

  @override
  _HistoryTempListState createState() => _HistoryTempListState();
}

class _HistoryTempListState extends State<HistoryTempList> {
  late Query _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("history").child("temperature");

  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('history')
        .child('temperature');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('temperature'),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
              children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0,left: 15,right: 15),
                  child: FirebaseAnimatedList(
                    // reverse: true,
                    // shrinkWrap: true,
                    query: _ref,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          shadowColor: Colors.black,
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      width: 60,
                                      image: AssetImage(
                                        'assets/images/temperature_icon.png',
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text((snapshot.value['time']).toString(), style: kBodyText.copyWith(color: Colors.black)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text((snapshot.value['value']).toString()+'\'C',
                                            style: kHeadline.copyWith(color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey.withOpacity(0.5),),
                                snapshot.value['photo']!=null?
                                ExpandablePanel(
                                  theme: ExpandableThemeData(
                                    expandIcon: Icons.arrow_downward,
                                    collapseIcon: Icons.arrow_upward,
                                  ),
                                  header: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("photo", style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.center,),
                                  ),
                                    collapsed: Center(),
                                    expanded: FutureBuilder(
                                      future: FireStorageService.loadImage(snapshot.value['photo']),
                                      builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                                          return Container(
                                            width: MediaQuery.of(context).size.width /1.2,
                                            height: MediaQuery.of(context).size.width /1.2,
                                            child: Image.network(snapshot.data!, fit: BoxFit.cover,),
                                          );
                                        }
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Container(
                                            width: MediaQuery.of(context).size.width /1.2,
                                            height: MediaQuery.of(context).size.width /1.2,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                )
                                    :SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

