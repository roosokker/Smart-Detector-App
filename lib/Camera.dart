import 'package:smartdetectorapp/DiseasePrediction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}
class _CameraState extends State<Camera> {
  File ImageFile;

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



  upload(File imageFile) async {
    var request = http.MultipartRequest("POST", Uri.parse("https://skin-decetor-app.herokuapp.com/RequestImageWithMetadata"));
    //add text fields

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("imagefile", imageFile.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    return responseString;

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

/*



  Widget _showdialogue()
  {
    AlertDialog(
      title: new Text("Please Choose One",
        style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.lightBlueAccent,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text("Upload Photo",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                ),),
              onTap: ()
              {
                _OpenGallery(context);
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
                _OpenCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }



  Widget _DetectImageFile()
  {
    if(ImageFile == null)
      Text("Please Select Image");
    else {
      Image.file(ImageFile, width: 400, height: 400,);
      new RaisedButton(onPressed:  null,
      color: Colors.lightBlueAccent,
      child: Text("Generate Reports" ,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),),);
    }
  }




 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(onPressed: ()
              {
                  _ShowChoices();
              },
                  icon: Icon(Icons.menu),
                  label: Text(" "),
              padding: EdgeInsets.only(left: 300.0),),

               // _DetectImageFile(),
              ImageFile == null ? Text("Please Insert an Image" , style:TextStyle(
                fontSize: 20.0)): Image.file(ImageFile , height: 400.0, width: 400.0,),

              FlatButton(onPressed: ()async{
                var result = await upload(ImageFile);
                print(result);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Prediction(ImageFile,result)
                ));
              } ,
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.teal),
                ),
                padding: EdgeInsets.only(left: 70.0 , right: 70.0 ),
                child: Text("Generate Reports" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0),),),

            ],
          ),
        ),
      ),
    );
  }
}
