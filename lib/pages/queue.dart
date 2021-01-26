import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/ticket.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Queue extends StatefulWidget {
  Queue({Key key}) : super(key: key);

  @override
  _QueueState createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  int tiempoEstimadoEspera = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    setState(() {
      compute(tiempoEspera, firebaseUser.uid);
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Cola Online"),
        ),
        drawer: MenuLateral(),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text("Tiempo Aproximado de Espera"),
                Text(
                  "${tiempoEstimadoEspera} min.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
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

  tiempoEspera(String uid) async {
    print("inicio");
    int nt = 0;
    int tiempoAtencion = 0;
    String localId;
    await FirebaseFirestore.instance
        .collection('colas')
        .orderBy('date', descending: false)
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((element) {
        print(element.id);
        if (element['uid'] == uid) {
          localId = element['localId'];
          print("---->" + localId);
          qs.docs.forEach((element2) {
            print("--->" + element.id);
            if (element2['localId'] == element['localId']) {
              nt++;
            }
          });
        }
      });
      print("nt");

      print(nt);
    });

    await FirebaseFirestore.instance
        .collection('locales')
        .doc(localId)
        .get()
        .then((DocumentSnapshot ds) {
      tiempoAtencion = ds['tiempoAtencion'];
      setState(() {
        tiempoEstimadoEspera = (nt - 1) * tiempoAtencion;
      });
    });
  }
}
