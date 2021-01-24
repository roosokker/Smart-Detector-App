import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdetectorapp/Register.dart';
import 'package:smartdetectorapp/Login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
        padding: EdgeInsets.symmetric(vertical: 0.0 , horizontal: 0.0),
        decoration: new BoxDecoration(
        image: new DecorationImage
          (image: new AssetImage("images/Home1.jpg"),
            fit: BoxFit.fill
          )
          ),
         child:Center(
         child: Column(
           children: <Widget>[
             new Padding(padding: EdgeInsets.only(top: 350.0)),
             new RaisedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) =>Login()
               )
               );
             } ,
               color: Colors.white,
               child: new Text("Login" ,
                 style: TextStyle(color: Colors.teal,
                     fontSize: 30.0),
               ),
               shape: RoundedRectangleBorder(
                 borderRadius: new BorderRadius.circular(18.0),
                 side: BorderSide(color: Colors.white),
               ),
               padding: EdgeInsets.only(left: 100.0 , right: 100.0 , top: 7.0 , bottom: 7.0),
               hoverColor: Colors.white,
               splashColor: Colors.white,
             ),
             new Padding(padding: EdgeInsets.only(top: 10.0)),
             new FlatButton(onPressed:(){
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => Register()
               )
               );
             } ,
               //color: Colors.white,
               child: new Text("Register" ,
                 style: TextStyle(color: Colors.white,
                     fontSize: 30.0),
               ),
               shape: RoundedRectangleBorder(
                 borderRadius: new BorderRadius.circular(18.0),
                 side: BorderSide(color: Colors.white),
               ),
               padding: EdgeInsets.only(left: 80.0 , right: 80.0 , top: 5.0 , bottom: 5.0),
               hoverColor: Colors.white,
               splashColor: Colors.white,
             )
           ],
         ),
         ),
        ),
    );
  }
}
