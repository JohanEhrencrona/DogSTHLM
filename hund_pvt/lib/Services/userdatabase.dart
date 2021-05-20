import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserDatabaseService {
  final String uid;

  UserDatabaseService ({this.uid});



  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future pushUserData(String name, String race, String age) async {
    try {
      return await users.doc(uid).set({
        'name': name,
        'race': race,
        'age': age,
      });
    } catch (FireBaseAuthException){
      handleError(FireBaseAuthException);
    }
  }
}

handleError (FirebaseAuthException error){
  return null;
}