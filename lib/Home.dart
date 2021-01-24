import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smartdetectorapp/Camera.dart';
import 'package:smartdetectorapp/History.dart';
import 'package:smartdetectorapp/Profile.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Camera _camera = new Camera();
  final History _history = new History();
  final Profile _profile = new Profile();
  Widget _showpage = new Camera();
  Widget _PageNavigator(int page)
  {
    switch(page){
      case 0:
        return _history;
        break;
      case 1:
        return _camera;
        break;
      case 2:
        return _profile;
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart App Detector" ,
          style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.history),
          Icon(Icons.camera_alt),
          Icon(Icons.person)
        ],
        index: 1,
        color: Colors.teal,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 200),
       animationCurve: Curves.bounceInOut,
       height: 50.0,
        onTap: (index)
        {
        setState(() {
            _showpage=_PageNavigator(index);
        });
        },
       // buttonBackgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child: _showpage,
        ),
      ),
    );
  }
}
