import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:flutter/material.dart';

class LocalesPage extends StatelessWidget {
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
            Text("locales"),
          ],
        ),
      ),
    );
  }
}
