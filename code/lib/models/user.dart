class RegularUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String role;
  final String imageUrl;

  RegularUser(
      {required this.uid,
      this.firstName = '',
      this.lastName = '',
      required this.phoneNumber,
      this.imageUrl = 'https://firebasestorage.googleapis.com/v0/b/cmsc190-lifeguard.appspot.com/o/displaypics%2Fdefault_avatar.png?alt=media&token=85b76591-1c4c-477e-9faa-22c1246c42e3',
      required this.role});

  RegularUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        phoneNumber = data['phoneNumber'],
        imageUrl = data['imageUrl'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'role': role,
    };
  }
}
