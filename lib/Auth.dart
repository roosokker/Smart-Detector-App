import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdetectorapp/UserClass.dart';

class AuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _UserFromFB(FirebaseUser FBuser)
  {
    return FBuser != null ? User(userID: FBuser.uid) : null;
  }
  Stream<User> get user
  {
    return _auth.onAuthStateChanged
        .map(_UserFromFB);
  }

  Future Register(String email , String Password) async
  {
    try
    {
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: Password);
     FirebaseUser user = result.user;
     return _UserFromFB(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  Future SignIn(String email , String Password) async
  {
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: Password);
      FirebaseUser user = result.user;
      return _UserFromFB(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  Future<String> GetCurrentUser() async
  {
    try
        {
          FirebaseUser user = await _auth.currentUser();
          final String uid = user.uid.toString();
          return uid;
        }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}