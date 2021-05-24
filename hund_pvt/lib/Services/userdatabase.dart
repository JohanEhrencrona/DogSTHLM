import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hund_pvt/Services/userswithdogs.dart';

class UserDatabaseService {
  final String uid;

  UserDatabaseService({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future pushUserData(String name, String race, String age) async {
    try {
      return await users.doc(uid).set({
        'name': name,
        'race': race,
        'age': age,
      });
    } catch (FireBaseAuthException) {
      handleError(FireBaseAuthException);
    }
  }

  Future addUserAndDogToApplication() async {
    var document = await users.doc(uid).get();
    Dog dog = Dog(
        name: document.get('name'),
        race: document.get('race'),
        age: int.parse(document.get('age')));
    userList.add(LoggedInUser(uid: uid, dog: dog));
  }
}

handleError(FirebaseAuthException error) {
  return null;
}
