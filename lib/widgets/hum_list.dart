import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sham_robot/const/styles.dart';
import 'package:sham_robot/widgets/appbar.dart';
import 'package:sham_robot/widgets/drawer.dart';

class HistoryHumList extends StatefulWidget {
  const HistoryHumList({Key? key}) : super(key: key);

  @override
  _HistoryHumListState createState() => _HistoryHumListState();
}

class _HistoryHumListState extends State<HistoryHumList> {
  late Query _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("history").child("humidity");

  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('history')
        .child('humidity');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('humidity'),
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
                                          'assets/images/humidity_icon.png',
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
                                          Text((snapshot.value['value']).toString()+'%',
                                              style: kHeadline.copyWith(color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
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
