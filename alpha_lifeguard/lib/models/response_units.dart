class ResponseUnit {
  final String uid;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String type;
  final String rsid;

  ResponseUnit(
      {required this.uid,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.type,
      required this.rsid});

  ResponseUnit.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        password = data['password'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        type = data['type'],
        rsid = data['rid'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'type': type,
      'rsid': rsid
    };
  }
}
