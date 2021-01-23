import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/pages/createLocal.dart';
import 'package:colasOnline/pages/miLocal.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    hasLocal(firebaseUser.uid, context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi Local "),
        ),
        drawer: MenuLateral(),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Future<bool> hasLocal(String uid, BuildContext c) async {
    await FirebaseFirestore.instance
        .collection('locales')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot qSnap) {
      if (qSnap.docs.length > 0) {
        Navigator.push(
          c,
          MaterialPageRoute(builder: (context) => MiLocal()),
        );
      } else {
        Navigator.push(
          c,
          MaterialPageRoute(builder: (context) => CreateLocal()),
        );
      }
    });
  }
}
