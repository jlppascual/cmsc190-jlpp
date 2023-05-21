import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encryptor/encryptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/response_units.dart';

class ResponderService extends GetxController {
  static ResponderService get instance => Get.find();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //password key to encrypt.decrypt
  var key = '';

  final CollectionReference _reportsCollection =
      FirebaseFirestore.instance.collection('user_reports');

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

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

  Future<dynamic> getUserReporterDetails(String uid) async {
    var res = await _userCollection.doc(uid).get();
    dynamic user = res.data();
    return user;
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamResponderDetails() {
    return _firebaseFirestore
        .collection('response_units')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getResponderReports() async* {
    var res;
    await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      res = value['type'];
    });
    yield* _firebaseFirestore
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

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getAcknowledgedResponderReports() async* {
    var res;
    await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      res = value['type'];
    });
    yield* _firebaseFirestore
        .collection("user_reports")
        .where('type', isEqualTo: res)
        .where('addressed', isEqualTo: true)
        .snapshots();
  }

    Future<dynamic> updateProfilePicture(String urlImage) async {
    try {
      _responderCollection
          .doc(_auth.currentUser!.uid)
          .update({'imageUrl': urlImage});
      return true;
    } catch (e) {
      return ('ERROR: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getFinishedResponderReports() async* {
    var res;
    await _responderCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      res = value['type'];
    });
    yield* _firebaseFirestore
        .collection("user_reports")
        .where('type', isEqualTo: res)
        .where('finished', isEqualTo: true)
        .snapshots();
  }

  void addressReport(String rid) async {
    try {
      _reportsCollection.doc(rid).update({'addressed': true});
    } catch (e) {
      //
    }
  }

  void finishReport(String rid) async {
    try {
      _reportsCollection.doc(rid).update({'finished': true});
    } catch (e) {
      //
    }
  }

  void cancelReport(String rid) async {
    try {
      _reportsCollection.doc(rid).update({'finished': false});
      _reportsCollection.doc(rid).update({'addressed': false});
    } catch (e) {
      //
    }
  }

  Future<dynamic> changeResponderPassword(
      String currPassword, String newPassword) async {
    DocumentSnapshot temp = await getResponderDetails();
    dynamic user = temp.data();

    var decryptedPassword = Encryptor.decrypt(key, user['password']);
    var encryptedPassword = Encryptor.encrypt(key, newPassword);

    if (decryptedPassword == currPassword) {
      try {
        _responderCollection
            .doc(_auth.currentUser!.uid)
            .update({'password': encryptedPassword});
        _auth.currentUser!.updatePassword(encryptedPassword);
        return true;
      } catch (e) {
        return e;
      }
    } else {
      return 'incorrect password!';
    }
  }

  Future<dynamic> changeResponderEmail(String newEmail, String password) async {
    DocumentSnapshot temp = await getResponderDetails();
    dynamic user = temp.data();

    var decryptedPassword = Encryptor.decrypt(key, user['password']);

    if (decryptedPassword == password) {
      try {
        _responderCollection
            .doc(_auth.currentUser!.uid)
            .update({'email': newEmail});
        _auth.currentUser!.updateEmail(newEmail);
      } catch (e) {
        return e;
      }
    } else {
      return 'Incorrect Password!';
    }
  }
}
