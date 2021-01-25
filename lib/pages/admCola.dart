import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:colasOnline/widgets/ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdmCola extends StatelessWidget {
  String idLocal;
  AdmCola(this.idLocal);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Administrar Cola"),
        ),
        drawer: MenuLateral(),
        body: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('colas')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("There is no expense");
                  } else {
                    return new Column(children: getColas(snapshot, idLocal));
                  }
                }),
          ],
        ));
  }

  getColas(AsyncSnapshot<QuerySnapshot> snapshot, String idlocal) {
    bool sw = true;
    snapshot.data.docs.forEach((element) {
      if (element["localId"] == idLocal && sw) {
        FirebaseFirestore.instance
            .collection('colas')
            .doc(element.id)
            .update({'estado': true});
        sw = false;
      }
    });
    if (snapshot.data.docs.length > 0) {
      return snapshot.data.docs
          .map((doc) => (idlocal == doc["localId"])
              ? Column(
                  children: [
                    Ticket(doc.id, doc["estado"], Colors.blue[400], ""),
                    doc["estado"]
                        ? RaisedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('colas')
                                  .doc(doc.id)
                                  .delete()
                                  .then((value) => {print("deleted")});
                            },
                            child: Text('Siguiente'),
                            color: Colors.blue[100],
                          )
                        : SizedBox.shrink()
                  ],
                )
              : SizedBox.shrink())
          .toList();
    } else {
      return [1]
          .map(
            (doc) => Text(
              "Aun no hay registros en la Cola Online de tu local",
              style: TextStyle(fontSize: 20),
            ),
          )
          .toList();
    }
  }
}
