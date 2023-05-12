import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import '../models/reports.dart';
import '../models/response_units.dart';
import '../models/user.dart';

class UserServices extends GetxController {
  static UserServices get instance => Get.find();
  //collection reference

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _reportsCollection =
      FirebaseFirestore.instance.collection('user_reports');

  String rid = '';

  Future createUser(RegularUser user) async {
    try {
      return await _userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Future sendReports(String type, String desc, String date, String time,
      Map<String, dynamic> coordinates) async {
    var ridGenerator = const Uuid(); //creates unique ids

    rid = ridGenerator.v4();
    var doesExist = await checkIfRidExist(rid);

    while (doesExist == true) {
      rid = ridGenerator.v4();
      doesExist = await checkIfRidExist(rid);
    }

    Report report = Report(
        uid: FirebaseAuth.instance.currentUser!.uid,
        rid: rid,
        desc: desc,
        type: type,
        date: date,
        time: time,
        coordinates: coordinates,
        finished: false,
        addressed: false);

    try {
      return await _reportsCollection.doc(report.rid).set(report.toJson());
    } catch (e) {
      return e.toString();
    }
  }

//to check if the generated rid of a user report already exists
  Future<bool> checkIfRidExist(String rid) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("user_reports").doc(rid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserReports() {
    return _firebaseFirestore
        .collection("user_reports")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
