import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/pages/queue.dart';
import 'package:colasOnline/widgets/localWidget.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan/barcode_scan.dart';

class LocalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Locales "),
      ),
      drawer: MenuLateral(),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('locales').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text("There is no expense");
                return new Column(children: getLocales(snapshot));
              })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: () {
          _scanQR(firebaseUser.uid, context);
        },
      ),
    );
  }

  getLocales(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => LocalWidget(doc["nombre"], doc["direccion"],
            doc["horario"], doc["tipo"], doc["estado"]))
        .toList();
  }

  Future _scanQR(String uid, BuildContext context) async {
    try {
      String qrResult = await BarcodeScanner.scan();
      scanQr(qrResult, uid, context);
      print(qrResult + "<-----------------");
    } catch (ex) {
      print(ex);
    }
  }
}

scanQr(String qr, String uid, BuildContext context) {
  FirebaseFirestore.instance
      .collection('locales')
      .doc(qr)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print(documentSnapshot["nombre"]);
      addCola(qr, uid, context);
    } else {
      print(qr + "no exite----------------------------");
      Fluttertoast.showToast(
          msg: "El Código QR no es valido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  });
}

addCola(String localId, String uid, BuildContext context) {
  FirebaseFirestore.instance
      .collection('colas')
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot qs) => {
            if (qs.docs.length > 0)
              {
                Fluttertoast.showToast(
                    msg: "Ya se encuentra en una Cola",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
            else
              {
                FirebaseFirestore.instance.collection('colas').add({
                  "localId": localId,
                  "uid": uid,
                  "date": DateTime.now(),
                  "estado": false
                }).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Queue(),
                    ),
                  );
                })
              }
          });
}
