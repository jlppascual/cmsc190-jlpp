class Establishment {
  final String uid;
  final String email;
  final String password;
  final String role;
  final String type;

  Establishment(
      {required this.uid,
      required this.email,
      required this.password,
      required this.role,
      required this.type});

  Establishment.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        password = data['password'],
        role = data['role'],
        type = data['type'];

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'password': password, 'role': role, 'type': type};
  }
}
