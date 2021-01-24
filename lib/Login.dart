import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdetectorapp/Auth.dart';
import 'package:smartdetectorapp/Home.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthServices _auth = AuthServices();
  final _formkey = GlobalKey<FormState>();
  String Email = "";
  String Password = " ";
  String error = " ";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.symmetric(vertical: 0.0 , horizontal: 0.0),
        decoration: BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/Login.png"),
              fit: BoxFit.fill,
          ),
        ),
          child:Form(
            key: _formkey,
          child: Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 335.0 , left: 150.0 , right: 150.0 )),
              new TextFormField(
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0 , right: 20.0),
                    prefixIcon: Icon(Icons.email),
                  enabledBorder: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),

                      focusedBorder: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),),
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),


                    hintText: "Enter Your Email",
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
                    prefixStyle: TextStyle(color: Colors.lightBlueAccent)
                  ),
                style: TextStyle(color: Colors.black , fontSize: 20.0),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? "Please Enter Email" : null,
                onChanged: (val) {Email = val;},
              ),

              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new TextFormField(
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0 , right: 20.0 ),
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),),
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                    ),

                    focusedBorder: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),),
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                    ),


                    hintText: "Enter Your Password",
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
                    prefixStyle: TextStyle(color: Colors.lightBlueAccent)
                ),
                style: TextStyle(color: Colors.black , fontSize: 20.0),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (val) => val.isEmpty ? "Please Enter Password" : null,
                onChanged: (val) {Password = val;},
              ),


              new FlatButton(onPressed: null,
                child: new Text("Forget Password?") ,
                padding: EdgeInsets.only(left: 200.0),),

              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new RaisedButton(onPressed: ()async {
                  if(_formkey.currentState.validate())
                    {
                      dynamic result = await _auth.SignIn(Email, Password);
                      if(result == null)
                        {
                          setState(() {
                            error = "Please Enter a Valid Email or Password";
                          });
                        }
                      else
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Home()
                          ));
                        }
                    }
              } ,
                color: Colors.teal,
                child: new Text("Login" ,
                  style: TextStyle(color: Colors.white,
                      fontSize: 30.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.lightBlueAccent),
                ),
                padding: EdgeInsets.only(left: 120.0 , right: 120.0 , top: 5.0 , bottom: 5.0),
                hoverColor: Colors.white,
                splashColor: Colors.white,
              ),

              SizedBox(height: 12.0,),
              new Text(error, style: TextStyle(color: Colors.red , fontSize: 20 ) , ),

            ],

        ),
          ),
      ),
    );
  }
}
