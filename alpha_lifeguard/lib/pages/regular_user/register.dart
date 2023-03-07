import 'package:alpha_lifeguard/pages/regular_user/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:alpha_lifeguard/pages/regular_user/login.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String phonenNum = "";

  final _formKey = GlobalKey<FormState>();

  final numController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    numController.addListener(() {
      debugPrint(numController.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                  height: 400,
                  child: Stack(
                    children: const <Widget>[
                      Positioned(
                          child: Center(
                              child: Text("REGISTER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold))))
                    ],
                  ))
            ]),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("+63 ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white)),
                          SizedBox(
                              width: 200,
                              child: TextFormField(
                                  controller: numController,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter number';
                                    }
                                    return null;
                                  },
                                  // onChanged: (text) {
                                  //   debugPrint('textfield : $text');
                                  // },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    labelText: 'Enter Number',
                                  )))
                        ]),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[100],
                              foregroundColor: Colors.red[700],
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // final user = User(
                                //   number: numController.text
                                // );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserHome()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Successfully registered!')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Error in registering!')));
                              }
                            },
                            child: const Text('Register'))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?',
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserLogin()));
                          },
                          child: const Text('Sign in!'),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        )));
  }
}
