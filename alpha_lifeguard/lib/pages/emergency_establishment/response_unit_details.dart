import 'package:flutter/material.dart';

class ResponseUnitDetails extends StatefulWidget {
  const ResponseUnitDetails(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email});

  final String firstName;
  final String lastName;
  final String email;

  @override
  State<ResponseUnitDetails> createState() => _ResponseUnitDetailsState();
}

class _ResponseUnitDetailsState extends State<ResponseUnitDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
          backgroundColor: Colors.red[700],
          foregroundColor: Colors.white,
          title: Text(
            'Response Unit Details',
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.firstName} ${widget.lastName}',
                  style: TextStyle(
                      color: Colors.red[700], fontWeight: FontWeight.w800),
                ),
                Text(
                  '${widget.email}',
                  style: TextStyle(
                      color: Colors.red[700], fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
