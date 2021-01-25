import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/ticket.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Queue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Cola Online"),
        ),
        drawer: MenuLateral(),
        body: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('colas')
                    .where('uid', isEqualTo: firebaseUser.uid)
                    // .orderBy('date', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("There is no expense");
                  } else {
                    return new Column(
                        children: getColas(snapshot, firebaseUser.uid));
                  }
                }),
          ],
        ));
  }

  getColas(AsyncSnapshot<QuerySnapshot> snapshot, String uid) {
    if (snapshot.data.docs.length > 0) {
      return snapshot.data.docs
          .map(
            (doc) => StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('colas')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("There is no expense");
                  } else {
                    return new Column(
                        children: getColasWidget(
                            snapshot, uid, snapshot.data.docs[0]['localId']));
                  }
                }),
          )
          .toList();
    } else {
      return [1]
          .map(
            (doc) => Text(
              "Aun no estas en alguna Cola Online",
              style: TextStyle(height: 20, fontSize: 20),
            ),
          )
          .toList();
    }
  }

  getColasWidget(
      AsyncSnapshot<QuerySnapshot> snapshot, String uid, String idLocal) {
    return snapshot.data.docs
        .map((doc) => (idLocal == doc['localId'])
            ? (uid == doc['uid'])
                ? Ticket(doc.id, doc["estado"], Colors.green[400], "you")
                : Ticket(doc.id, doc["estado"], Colors.blue[400], "")
            : SizedBox.shrink())
        .toList();
  }
}
