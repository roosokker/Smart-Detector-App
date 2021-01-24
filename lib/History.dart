import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  String DisName = " ";
  String DisInfo = " ";
  String url ;
  FirebaseUser user;
  Future<String> getUserData() async{
    FirebaseUser userData= await FirebaseAuth.instance.currentUser();
    String phone ="";
    setState(() async {
      user=userData;
      final firestoreInstance = Firestore.instance;
      print("ready");
      print(user.uid);
      return await firestoreInstance.collection("History").document(user.uid).get().then((value) async {
        DisName = value.data['DiseaseName'];
        DisInfo = value.data['Disease Info'];
        url = value.data['Disease Image'];
      });
    });
    print("History URL" + " " + url);

  }
  @override
  void initState(){
    super.initState();
    print("next");
    setState(() async {
      await getUserData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: <Widget>[
          Image.network(url),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Text(DisName , style: TextStyle(
              fontSize: 20.0 , color: Colors.black
          ),),
          Padding(padding: EdgeInsets.only(top: 10.0),),
          Text(DisInfo , style: TextStyle(
              fontSize: 15.0 , color: Colors.black45
          ),),
        ],
      ),
    );
  }
}


/*
class History extends StatelessWidget {

  FirebaseAuth auth = FirebaseAuth.instance;
  String Userid = "" ;
  void getuser () async {
    FirebaseUser user = await auth.currentUser();
    Userid = user.uid;
  }


  Stream<QuerySnapshot> getUserData(BuildContext context)async*{
    Firestore.instance.collection("History").document(Userid).snapshots();
  }




  @override
  Widget build(BuildContext context) {
    getuser();
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: getUserData(context),
            builder: (context , snapshot) {
              if(!snapshot.hasData) return Text("Loading data Please wait...");
              return new ListView.builder(itemCount: snapshot.data.documents.length
                  ,itemBuilder:(BuildContext context , int index) =>
                      BuildHistoryCard(context, snapshot.data.documents[index]));
            },
          )
        ],
      ),
    );
  }

  Widget BuildHistoryCard(BuildContext context , DocumentSnapshot document)
  {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0 , bottom: 4.0),
                child: Column(
                  children: <Widget>[
                    Text(document['DiseaseName']),
                    Text(document['Disease Info']),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/

