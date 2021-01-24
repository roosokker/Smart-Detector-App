import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
class DataBaseService
{
  
  final String UserID ;
  String DiseaseName;
  String DiseaseInfo;
  File Image;
  String url;
  DataBaseService({this.UserID });

  Future<String> uploadImage(Image) async{
    final StorageReference postImageref = FirebaseStorage.instance.ref().child("Post Images");
    final StorageUploadTask uploadTask = postImageref.putFile(Image);
    var imageurl = await(await uploadTask.onComplete).ref.getDownloadURL();
    print("DBClass url before convert to string" + " " +imageurl);
    url = imageurl.toString();
    print("DBClass url after vonvert to string" + " " +url);
    return url;
  }

  final CollectionReference UserDiseaseData = Firestore.instance.collection("History");
  Future UpdateUserData(url,DiseaseName , DiseaseInfo) async {
    print("UserID Database UPdate"+UserID);
    print("URL in Database Class" +  " " + url);
    return await UserDiseaseData.document(UserID).setData({
      'Disease Image' : url,
      'DiseaseName' : DiseaseName,
      'Disease Info' : DiseaseInfo,
    });
  }

  final CollectionReference UserData = Firestore.instance.collection("UserData");
  Future UpdateUserInfo (String Username , String Email , String age , String Gender)async
  {
    return await UserData.document(UserID).setData({
      'UserName' : Username,
      'Email' : Email,
      'Age' : age,
      'Gender' : Gender,
    });
  }
}