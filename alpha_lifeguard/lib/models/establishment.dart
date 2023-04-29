class Establishment {
  final String uid;
  final String email;
  final String password;
  final String role;

  Establishment(
      {required this.uid,
      required this.email,
      required this.password,
      required this.role});

  Establishment.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        password = data['password'],
        role = data['role'];

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'password': password, 'role': role};
  }
}
