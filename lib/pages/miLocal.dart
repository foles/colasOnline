import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/services/localService.dart';
import 'package:flutter/cupertino.dart';

class MiLocal extends StatefulWidget {
  MiLocal({Key key}) : super(key: key);

  @override
  _MiLocalState createState() => _MiLocalState();
}

class _MiLocalState extends State<MiLocal> {
  bool flag = false;
  var locales;

  @override
  // void initState() {
  //   super.initState();
  //   LocalService().getlocal("dasdasdasd").then((QuerySnapshot docs) {
  //     if (docs.docs.isNotEmpty) {
  //       flag = true;
  //       locales = docs.docs[0].data;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: flag ? Text(locales['nombre']) : Text("nada"),
    );
  }
}
