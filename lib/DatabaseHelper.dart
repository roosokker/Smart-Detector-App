import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DBHelper{
  DBHelper._PrivateConstructor();
  static final DBHelper instance = DBHelper._PrivateConstructor();
  static final _DBName = "UserDB.db";
  static final _DBVersion = 1;
  static final _TableName = "User";
  String UserID = "";
  String UserName = "";
  String UserAge ;
  String Gender = "";

  static Database _db;
  Future<Database> get database async {
    if (_db != null)
      return _db;
    else {
      _db = await _initiatedb();
      return _db;
    }
  }

  _initiatedb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path , _DBName);
    return await openDatabase(path , version: _DBVersion , onCreate: _OnCreate);
  }

  Future _OnCreate(Database db , int version)
  {
   db.execute('''
   CREATE TABLE User (
   UserID TEXT PRIMARY KEY,
   UserName TEXT NOT NULL,
   UserAge TEXT NOT NULL,
   Gender TEXT NOT NULL,
   ) 
   ''') ;
  }

  Future<int> insert(Map<String,dynamic> data) async
  {
     Database db = await instance.database;
     return await db.insert(_TableName, data);
  }

  Future <List<Map<String , dynamic>>> getuserdata(String uid) async
  {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $_TableName where $UserID = ?' , [uid]);
  }


}