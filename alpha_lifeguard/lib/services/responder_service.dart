import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/reports.dart';
import '../models/response_units.dart';

class ResponderService extends GetxController {
  static ResponderService get instance => Get.find();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _reportsCollection =
      FirebaseFirestore.instance.collection('user_reports');

  final CollectionReference _responderCollection =
      FirebaseFirestore.instance.collection('response_units');

  Future createResponder(ResponseUnit unit) async {
    try {
      return await _responderCollection.doc(unit.uid).set(unit.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  //checks if the generated rsid of a response unit already exists
  Future<bool> checkIfRsidExist(String rid) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("response_units").doc(rid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<DocumentSnapshot> getResponderDetails() async {
    return await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

   Stream<QuerySnapshot<Map<String, dynamic>>> getResponderReports() async* {
    var res;
    await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      res = value['type'];
    });
    yield*  _firebaseFirestore
        .collection("user_reports")
        .where('type', isEqualTo: res)
        .snapshots();

    // return data.docs
    //     .map((doc) => Report(
    //         uid: doc['uid'],
    //         rid: doc['rid'],
    //         coordinates: doc['coordinates'],
    //         type: doc['type'],
    //         date: doc['date'],
    //         time: doc['time']))
    //     .toList();
  }

   void addressReport(String rid) async {
    try {
      _reportsCollection.doc(rid).update({'addressed': true}).then(
          (value) => print('successful update!'));
    } catch (e) {
      print(e.toString());
    }
  }
}
