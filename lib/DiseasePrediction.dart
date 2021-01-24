import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:smartdetectorapp/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smartdetectorapp/UserClass.dart';
import 'Database.dart';
import 'package:path/path.dart' as Path;


File DImage;
String DiseaseName = " ";
class Prediction extends StatefulWidget {

  Prediction(File img , String nae ){
    DImage = img ;
    DiseaseName = nae;
  }
  @override
  _PredictionState createState() => _PredictionState();
}
String _uploadedFileURL;
class _PredictionState extends State<Prediction> {


  User user = User();
  DataBaseService _dataBaseService = new DataBaseService();
  String uid;
  String url;
    FirebaseAuth auth = FirebaseAuth.instance;
    getUser() async
    {
      FirebaseUser user = await auth.currentUser();
      uid = user.uid;
      print("UserID InitState"+uid);
    }


  String DiseaseInfo =" ";
  String _GetDisInfo(String DisName)
  {
    DisName = DiseaseName;
    if(DisName == "Skin Diseas is Psoriasis ")
      {
        DiseaseInfo = '''
        Psoriasis was originally considered a
        benign skin condition with minimal 
        serious complications.
        However, numerous recent studies
        have unequivocally shown that psoriasis
        is a systemic inflammatory disease,  
        ''';
      }
    else if(DisName == "Skin Disease is vitiligo")
      {
        DiseaseInfo = '''
        Vitiligo is a condition that causes patchy
        loss of skin coloring (pigmentation).
        The average age of onset of vitiligo
        is in the mid-twenties, 
        but it can appear at any age.
        It tends to progress over time, 
        with larger areas of the skin losing pigment.
        Some people with vitiligo also have patches
        of pigment loss affecting the hair on their scalp or body.
        ''';
      }
    else if(DisName == "Skin Disease is melanoma")
      {
        DiseaseInfo = '''
        Melanoma is much less common than
        some other types of skin cancers.
        But melanoma is more dangerous
        because it’s much more likely
        to spread to other parts of the
        body if not caught and treated early.
        ''';
      }
    return DiseaseInfo;
  }
  Future uploadFile() async {

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('ImageHistory/${Path.basename(DImage.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(DImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print("URLLLLLLLLLLLLLLLLLL      " +fileURL);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Information",style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.teal,
      ),

      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image == null ? Text("No Picture Taken! Please Take Pictutre First") :
            Image.file(DImage , width: 600.0, height: 250.0,),
            Text(DiseaseName , style: TextStyle(
              fontSize: 20.0, color: Colors.black,
            ),),
            Text(_GetDisInfo(DiseaseName ) , style: TextStyle(
              fontSize: 15.0 , color: Colors.black45,
            ),),
            RaisedButton(onPressed: (){
              setState(() {
                getUser();
                print("UserID Button setState"+uid);
                uploadFile();
                //url= DataBaseService(UserID: uid).uploadImage(widget.Image).toString();
                //print("widget url after return" + " " + url);
                print("URLL in Button Press" +  " " +_uploadedFileURL);
                DataBaseService(UserID: uid).UpdateUserData(_uploadedFileURL,DiseaseName, DiseaseInfo);
              });
            },
            color: Colors.teal,
                child: new Text("Save Info" ,
              style: TextStyle(color: Colors.white,
                  fontSize: 20.0),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50.0),
          side: BorderSide(color: Colors.teal),
        ),
      //  padding: EdgeInsets.only(left: 120.0 , right: 120.0 , top: 5.0 , bottom: 5.0),
        hoverColor: Colors.white,
        splashColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
