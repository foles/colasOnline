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
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text("There is no expense");
                  return colas();
                }),
          ],
        ));
  }

  Column colas() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '\n\nHorario promedio de atención 30 min ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Ticket("Juan Mendoza", "123123", "14:30 - 15:00", "Atendiendo",
            Colors.blue[400]),
        Ticket("Juan Perez", "789456", "15:00 - 15:30", "En Espera",
            Colors.indigoAccent[400]),
        Ticket("Anibal Gonzales", "789456", "15:30 - 16:00", "En Espera",
            Colors.indigoAccent[400]),
        Ticket("Pedro Tarifa", "789456", "16:00 - 16:30", "En Espera",
            Colors.indigoAccent[400]),
        Ticket("Fatima Lopez", "789456", "16:30 - 17:00", "En Espera",
            Colors.indigoAccent[400]),
        Ticket("Maria Ortiz", "789456", "17:00 - 17:30", "En Espera",
            Colors.indigoAccent[400]),
        Ticket("Jamil Silva", "789456", "18:00 - 18:30", "En Espera",
            Colors.green),
        Ticket("Zoe Condori", "789456", "19:00 - 20:00", "En Espera",
            Colors.indigoAccent[400]),
      ],
    );
  }
}
