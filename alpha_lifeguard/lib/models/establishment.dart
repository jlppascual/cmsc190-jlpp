class Establishment {
  final String uid;
  final String email;
  final String password;
  final String role;
  final String type;
  final String name;

  Establishment(
      {required this.uid,
      required this.email,
      required this.password,
      required this.role,
      required this.type,
      this.name = ''
      });

  Establishment.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        password = data['password'],
        role = data['role'],
        type = data['type'],
        name = data['name'];

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'password': password, 'role': role, 'type': type, 'name':name};
  }
}
