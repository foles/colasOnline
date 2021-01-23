import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/localWidget.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiLocal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Local"),
      ),
      drawer: MenuLateral(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('locales')
              .where('uid', isEqualTo: firebaseUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("There is no expense");
            return new ListView(children: getExpenseItems(snapshot));
          }),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => LocalWidget(doc["nombre"], doc["direccion"],
            doc["horario"], doc["tipo"], doc["estado"]))
        .toList();
  }
}
