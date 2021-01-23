import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colasOnline/widgets/menuLateral.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLocal extends StatelessWidget {
  final TextEditingController nombreC = TextEditingController();
  final TextEditingController horarioC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: AppBar(title: Text("Registrar Local")),
      drawer: MenuLateral(),
      body: Center(
        child: Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/store.png',
                  height: 150,
                ),
                Text(""),
                TextFormField(
                  controller: nombreC,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Nombre del Local';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Nombre del Local'),
                ),
                TextFormField(
                  controller: horarioC,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Ingrese horario';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Tiempo de Atención'),
                ),
                TextFormField(
                  controller: nombreC,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Nombre del Local';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                TextFormField(
                  controller: nombreC,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Nombre del Local';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Dirección'),
                ),
                TextFormField(
                  controller: nombreC,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Nombre del Local';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Telefono o Celular'),
                ),
                Text("\n\n"),
                RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      addLocal(nombreC.text.trim(), horarioC.text.trim(),
                          firebaseUser.uid);
                    },
                    child: Text(
                      'Registrar Local',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

addLocal(String nombre, String horario, String uid) {
  Map<String, dynamic> demoData = {
    "nombre": "$nombre",
    "horario": "$horario",
    "uid": "$uid",
  };

  CollectionReference cr = FirebaseFirestore.instance.collection('locales');
  cr.add(demoData);
}
