import 'package:flutter/material.dart';
import 'package:sham_robot/methods.dart';
import 'package:sham_robot/route/routing_consts.dart';
import 'package:sham_robot/screens/dashboard_screen.dart';
import 'package:sham_robot/screens/history.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Drawer(
        child:
        Column(
          children: [
            buildHeader(),
            ListTile(
              leading: Icon(Icons.home, color: Colors.black,),
              title: Text('Home', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DashboardScreen())),
            ),
            ListTile(
              leading: Icon(Icons.history_edu,color: Colors.black,),
              title: Text('History', style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => History(indexx: 0,))),
            ),
            Divider(color: Colors.black38),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black,),
              title: Text('Déconnecter', style: TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold),),
              onTap: () => _signOut(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 200,
              color: Color.fromRGBO(42, 159, 244, 1),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  height: 100, //140
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image(
                    width: 100,
                    image: AssetImage("assets/images/robot_icon2.png"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _signOut() async {
    await AuthHelper.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, SplashScreenRoute, (Route<dynamic> route) => false);
  }
}
class CustomShape extends CustomClipper<Path>{
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height-10);
    path.quadraticBezierTo(
        size.width/2, size.height,
        size.width, size.height-50);
    path.lineTo(size.width ,0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
