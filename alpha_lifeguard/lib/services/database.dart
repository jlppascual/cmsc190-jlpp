import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid});
  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future createUser(String number) async{
    return await userCollection.doc(uid).set({
      'number': number,
    });
  }

}