import 'package:alpha_lifeguard/models/reports.dart';

class RegularUser {
  final String uid;
  final String phoneNumber;
  final String role;

  RegularUser(
      {required this.uid, required this.phoneNumber, required this.role});

  RegularUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        phoneNumber = data['phoneNumber'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
