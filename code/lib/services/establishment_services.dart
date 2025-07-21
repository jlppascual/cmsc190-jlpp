import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encryptor/encryptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/establishment.dart';

class EstablishmentServices extends GetxController {
  static EstablishmentServices get instance => Get.find();
  //collection reference

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _establishmentCollection=
      FirebaseFirestore.instance.collection('establishments');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //password key to encrypt.decrypt
  var key = '';

  Future createEstablishment(Establishment user) async {
    try {
      return await _establishmentCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEstablishmentResponders() {
    return _firebaseFirestore
        .collection("response_units")
        .where('rsid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('lastName')
        .snapshots();
  }

  Future<DocumentSnapshot> getEstablishmentDetails() async {
    return await _establishmentCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<dynamic> changeEstablishmentEmail(
      String newEmail, String password) async {
    DocumentSnapshot temp = await getEstablishmentDetails();
    dynamic user = temp.data();

    var decryptedPassword = Encryptor.decrypt(key, user['password']);

    if (decryptedPassword == password) {
      try {
        _establishmentCollection.doc(_auth.currentUser!.uid).update({'email': newEmail});
        _auth.currentUser!.updateEmail(newEmail);
        return true;
      } catch (e) {
        return e;
      }
    } else {
      return 'Incorrect Password!';
    }
  }

    Stream<QuerySnapshot<Map<String, dynamic>>> getStreamEstablishmentDetails() {
    return _firebaseFirestore
        .collection('establishments')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  
  Future<dynamic> changeEstablishmentPassword(
      String currPassword, String newPassword) async {
    DocumentSnapshot temp = await getEstablishmentDetails();
    dynamic user = temp.data();

    var decryptedPassword = Encryptor.decrypt(key, user['password']);
    var encryptedPassword = Encryptor.encrypt(key, newPassword);

    if (decryptedPassword == currPassword) {
      try {
        _establishmentCollection
            .doc(_auth.currentUser!.uid)
            .update({'password': encryptedPassword});
        _auth.currentUser!.updatePassword(newPassword);
        return true;
      } catch (e) {
        return e;
      }
    } else {
      return 'incorrect password!';
    }
  }
}
