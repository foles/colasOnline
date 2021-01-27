import 'package:colasOnline/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Waiting extends StatefulWidget {
  Waiting({Key key}) : super(key: key);

  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      context.read<AuthenticationService>().signOut(context);
    });

    return Scaffold(
      body: Center(
        child: Text("Esperando"),
      ),
    );
  }
}
