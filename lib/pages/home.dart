import 'package:colasOnline/services/authentication_service.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Locales"),
      ),
      drawer: MenuLateral(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {},
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
