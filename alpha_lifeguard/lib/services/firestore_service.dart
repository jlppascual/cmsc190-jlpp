import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import '../models/establishment.dart';
import '../models/reports.dart';
import '../models/response_units.dart';
import '../models/user.dart';

class FirestoreService extends GetxController {
  static FirestoreService get instance => Get.find();
  //collection reference

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _reportsCollection =
      FirebaseFirestore.instance.collection('user_reports');

  final CollectionReference _establishmentCollection =
      FirebaseFirestore.instance.collection('establishments');

  final CollectionReference _responderCollection =
      FirebaseFirestore.instance.collection('response_units');

  String rid = '';

  Future createUser(RegularUser user) async {
    try {
      return await _userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Future createEstablishment(Establishment user) async {
    try {
      return await _userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Future createResponder(ResponseUnit unit) async {
    try {
      return await _responderCollection.doc(unit.uid).set(unit.toJson());
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

  Future<bool> checkIfRidExist(String rid) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("user_reports").doc(rid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfRsidExist(String rid) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("response_units").doc(rid).get();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getEstablishmentResponders() {
    return _firebaseFirestore
        .collection("response_units")
        .where('rsid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future<Iterable<Report>> getResponderReports() async {
    var res;
    await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      res = value['type'];
    });
    var data = await _firebaseFirestore
        .collection("user_reports")
        .where('type', isEqualTo: res)
        .get();

    return data.docs
        .map((doc) => Report(
            uid: doc['uid'],
            rid: doc['rid'],
            coordinates: doc['coordinates'],
            type: doc['type'],
            date: doc['date'],
            time: doc['time']))
        .toList();
  }
}
