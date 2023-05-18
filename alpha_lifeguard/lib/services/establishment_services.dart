import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/establishment.dart';

class EstablishmentServices extends GetxController {
  static EstablishmentServices get instance => Get.find();
  //collection reference

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future createEstablishment(Establishment user) async {
    try {
      return await _userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEstablishmentResponders() {
    return _firebaseFirestore
        .collection("response_units")
        .where('rsid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
