import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File ImageFile;

  String name = "";
  String Email = "";
  String age = "";
  String Gender = "";


  FirebaseUser user;
  Future<String> getUserData() async{
    FirebaseUser userData= await FirebaseAuth.instance.currentUser();
    String phone ="";
    setState(() {
      user=userData;
      final firestoreInstance = Firestore.instance;
      print("ready");
      print(user.uid);
      firestoreInstance.collection("UserData").document(user.uid).get().then((value) async {
        name = value.data['UserName'];
        Email = value.data['Email'];
        age = value.data['Age'];
        Gender = value.data['Gender'];
      });
    });
  }
  @override
  void initState(){
    super.initState();
    print("next");
    setState(() {
      getUserData();
    });

  }

  Future _OpenGallery()async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      ImageFile = image;
    });
    Navigator.of(context).pop();
  }

  Future _OpenCamera()async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      ImageFile = image;
    });
    Navigator.of(context).pop();
  }

  Future<void> _ShowChoices()
  {
    return showDialog(context: context , builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text("Please Select One",
          style: TextStyle(
            color: Colors.black,
          ),),
        backgroundColor: Colors.teal,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Upload Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),),
                onTap: ()
                {
                  _OpenGallery();
                },
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
              GestureDetector(
                child: Text("Take Photo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                  ),),
                onTap: ()
                {
                  _OpenCamera();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal , Colors.tealAccent],
              )
            ),
            child: Container(
              width: double.infinity,
              height: 230.0,
              child: Center(
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ImageFile == null ? AssetImage("images/userlogo.png") :
                      Image.file(ImageFile, width: 10.0, height: 10.0,),
                      radius: 70.0,
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: InkWell(
                        onTap: () {
                          _ShowChoices();
                        },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.teal,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          new TextFormField(
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
              hintText: "Name: " + name,
              hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
            ),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? "Please Enter Your Age" : null,
            onChanged: (val){},
          ),
          new TextFormField(
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
              hintText: "Email: " + Email,
              hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
            ),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? "Please Enter Your Age" : null,
            onChanged: (val){},
          ),
          new TextFormField(
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
              hintText: "Age: " + age,
              hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
            ),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? "Please Enter Your Age" : null,
            onChanged: (val){},
          ),
          new TextFormField(
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
              hintText: "Gender: " + Gender,
              hintStyle: TextStyle(fontSize: 15.0 , color: Colors.grey),
            ),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? "Please Enter Your Age" : null,
            onChanged: (val){},
          ),
        ],
      ),
    );
  }
}
