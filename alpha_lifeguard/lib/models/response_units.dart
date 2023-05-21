class ResponseUnit {
  final String uid;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String type;
  final String rsid;
  final String imageUrl;

  ResponseUnit(
      {required this.uid,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.type,
      required this.rsid,
      this.imageUrl = 'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/displaypics%2Fdefault_avatar.png?alt=media&token=85b76591-1c4c-477e-9faa-22c1246c42e3',
      });

  ResponseUnit.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        password = data['password'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        type = data['type'],
        rsid = data['rid'],
        imageUrl = data['imageUrl'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'type': type,
      'rsid': rsid,
      'imageUrl': imageUrl
    };
  }
}
