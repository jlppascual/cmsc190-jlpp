class RegularUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String role;

  RegularUser(
      {required this.uid,
      this.firstName = '',
      this.lastName = '',
      required this.phoneNumber,
      required this.role});

  RegularUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        phoneNumber = data['phoneNumber'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
