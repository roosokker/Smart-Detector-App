import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdetectorapp/Auth.dart';
import 'package:smartdetectorapp/Login.dart';
import 'Database.dart';
import 'DatabaseHelper.dart';
class Register extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  AuthServices _auth = AuthServices();

  final _formkey = GlobalKey<FormState>();
  String Email = "";
  String Password = " ";
  String error = " ";
  String UserName = " ";
  String Gender = " ";
  String age;
  String UserID = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.symmetric(vertical: 0.0 , horizontal: 0.0),
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/Register.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:Form(
          key: _formkey,
        child: Column(

          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 230.0 , left: 50.0 , right: 50.0 )),

            new TextFormField(
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(left: 30.0 , right: 30.0),
                prefixIcon: Icon(Icons.person),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0)
                  ),
                  borderSide: BorderSide(
                  color: Colors.teal,
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),),
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                ),
                  hintText: "Enter Your Name",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
                  prefixStyle: TextStyle(color: Colors.teal)
              ),
              style: TextStyle(color: Colors.black , fontSize: 20.0),
              keyboardType: TextInputType.text,
              validator: (val) => val.isEmpty ? "Please Enter your Name" : null,
              onChanged: (val) {UserName = val;},
            ),

            new Padding(padding: EdgeInsets.only(top: 10.0)),
            new TextFormField(
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(left: 30.0 , right: 30.0),
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),

                  focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),


                  hintText: "Enter Your Email",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
                  prefixStyle: TextStyle(color: Colors.teal)
              ),
              style: TextStyle(color: Colors.black , fontSize: 20.0),
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val.isEmpty ? "Please Enter Email" : null,
              onChanged: (val) {Email = val;},
            ),

            new Padding(padding: EdgeInsets.only(top: 10.0)),
            new TextFormField(
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(left: 30.0 , right: 30.0 ),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),

                  focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),),
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),


                  hintText: "Enter Your Password",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
                  prefixStyle: TextStyle(color: Colors.teal)
              ),
              style: TextStyle(color: Colors.black , fontSize: 20.0),
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (val) => val.isEmpty ? "Please Enter Password" : null,
              onChanged: (val) {Password = val;},
            ),

            new Padding(padding: EdgeInsets.only(left: 50.0,top: 10.0 ,right: 50.0)),
            new TextFormField(
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
                hintText: "Enter Your Age",
                hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
              validator: (val) => val.isEmpty ? "Please Enter Your Age" : null,
              onChanged: (val){age = val;},
            ),


            new Padding(padding: EdgeInsets.only(top: 5.0)),
            new Row(
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(left: 20.0)),
                Text("Male",style: TextStyle(color: Colors.teal , fontSize: 20.0),),
               new Radio(activeColor: Colors.teal ,value: "Male" , groupValue: Gender, onChanged: (newvalue) {setState(() {
                 Gender = newvalue;
               });}),
                new Padding(padding:EdgeInsets.only(left: 120.0)),
                Text("Female",style: TextStyle(color: Colors.teal , fontSize: 20.0),),
                new Radio(activeColor: Colors.teal,value: "Female", groupValue: Gender , onChanged: (newvalue){setState(() {
                  Gender = newvalue;
                });}),
              ],
            ),


            new Padding(padding: EdgeInsets.only(top: 20.0)),
            new RaisedButton(onPressed: ()async{
              if(_formkey.currentState.validate())
                {
                  print("User Name" + UserName + " " + "UserAge" + age + " " + "Gender " + Gender);
                  dynamic result = await _auth.Register(Email, Password);
                  if(result == null)
                    {
                      setState(() {
                        error = "Please Enter a Valid Email or Password";
                      });
                    }
                  else
                    {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      FirebaseUser user = await auth.currentUser();
                      UserID = user.uid;
                      print("UserID" + " " + UserID);
                      DataBaseService(UserID: UserID).UpdateUserInfo(UserName, Email, age, Gender);

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Login()
                        ));
                      }
                }

              //Database Sqllite storage
            } ,
              color: Colors.teal,
              child: new Text("Create Account" ,
                style: TextStyle(color: Colors.white,
                    fontSize: 20.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.teal),
              ),
              padding: EdgeInsets.only(left: 60.0 , right: 60.0 , top: 5.0 , bottom: 5.0),
              hoverColor: Colors.white,
              splashColor: Colors.white,
            ),

            SizedBox(height: 10.0,),
            new Text(error, style: TextStyle(color: Colors.red , fontSize: 15 ) , ),

          ],

        ),
        ),
      ),
    );
  }
}
