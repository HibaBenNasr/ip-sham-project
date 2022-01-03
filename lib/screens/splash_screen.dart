import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sham_robot/const/colors.dart';
import 'package:sham_robot/const/styles.dart';
import 'package:sham_robot/route/routing_consts.dart';

import '../methods.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainBG,
        body: FutureBuilder(
          future: AuthHelper.initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              User? user = AuthHelper.currentUser();
              if (user != null) {
                Future.delayed(Duration.zero, () async {
                  Navigator.pushNamedAndRemoveUntil(context, DashboardScreenRoute,
                          (Route<dynamic> route) => false);
                });
              } else {
                return _getScreen(context);
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  _getScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage(
                        'assets/images/iot_image.png',
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "welcome to our Application !",
                  style: kHeadline,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "\nYour security and comfrot is important for us wherever and whenever you are,\nThank you!",
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        SignInScreenRoute, (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'GET STARTED',
                    style: kButtonText.copyWith(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
