import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/pages/admCola.dart';
import 'package:colasOnline/widgets/localWidget.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MiLocal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Mi Local"),
        ),
        drawer: MenuLateral(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('locales')
                    .where('uid', isEqualTo: firebaseUser.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text("There is no expense");
                  return new Column(children: getLocal(snapshot));
                }),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      cambiarEstado(firebaseUser.uid);
                    },
                    child: Text(
                      'Activar Estado',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('locales')
                          .where('uid', isEqualTo: firebaseUser.uid)
                          .get()
                          .then((QuerySnapshot qs) => {
                                qs.docs.forEach((element) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdmCola(element.id)),
                                  );
                                })
                              });
                    },
                    child: Text(
                      'Administrar Cola',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('locales')
                    .where('uid', isEqualTo: firebaseUser.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text("There is no expense");
                  return new Column(children: getQr(snapshot));
                }),
          ],
        ));
  }
}

getLocal(AsyncSnapshot<QuerySnapshot> snapshot) {
  snapshot.data.docs.map((e) => print(e["nombre"]));
  return snapshot.data.docs
      .map((doc) => LocalWidget(doc["nombre"], doc["direccion"], doc["horario"],
          doc["tipo"], doc["estado"]))
      .toList();
}

getQr(AsyncSnapshot<QuerySnapshot> snapshot) {
  snapshot.data.docs.map((e) => print(e["nombre"]));
  return snapshot.data.docs
      .map((doc) => QrImage(
            data: doc.id,
            size: 300,
          ))
      .toList();
}

Future<void> cambiarEstado(String uid) {
  print("asd");
  getIdLocal(uid).then((value) {
    print(value);
  });
  FirebaseFirestore.instance
      .collection('locales')
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              updateEstado(doc.id, doc["estado"]);
            })
          });
}

Future<String> getIdLocal(String uid) async {
  await FirebaseFirestore.instance
      .collection('locales')
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              return doc.id;
            })
          });
}

Future<void> updateEstado(String idDoc, bool estado) {
  print(idDoc);
  FirebaseFirestore.instance
      .collection('locales')
      .doc(idDoc)
      .update({'estado': !estado});
}
